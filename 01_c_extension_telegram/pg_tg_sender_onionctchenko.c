#include "postgres.h"
#include "fmgr.h"
#include "libpq/libpq-be.h"
#include "utils/builtins.h"
#include <dlfcn.h>

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(send_to_telegram);

Datum send_to_telegram(PG_FUNCTION_ARGS)
{
    char *bot_token = text_to_cstring(PG_GETARG_TEXT_PP(0));
    char *chat_id = text_to_cstring(PG_GETARG_TEXT_PP(1));
    char *message_text = text_to_cstring(PG_GETARG_TEXT_PP(2));

    // Динамическая загрузка libcurl
    void *libcurl_handle = dlopen("libcurl.so.4", RTLD_LAZY);
    if (!libcurl_handle) {
        elog(ERROR, "Ошибка загрузки libcurl: %s", dlerror());
        PG_RETURN_BOOL(false);
    }

    // Получение указателя на curl_easy_perform
    CURLcode (*curl_easy_perform)(CURL *) = dlsym(libcurl_handle, "curl_easy_perform");
    if (!curl_easy_perform) {
        elog(ERROR, "Ошибка получения символа curl_easy_perform: %s", dlerror());
        dlclose(libcurl_handle);
        PG_RETURN_BOOL(false);
    }

    CURL *curl;
    CURLcode res;

    char url[256];
    snprintf(url, sizeof(url), "https://api.telegram.org/bot%s/sendMessage", bot_token);

    char post_data[1024];
    snprintf(post_data, sizeof(post_data), "chat_id=%s&text=%s", chat_id, message_text);

    // Вызов функций инициализации через dlsym (для упрощения кода в рамках лабы)
    void (*curl_global_init)(long) = dlsym(libcurl_handle, "curl_global_init");
    CURL* (*curl_easy_init)(void) = dlsym(libcurl_handle, "curl_easy_init");
    CURLcode (*curl_easy_setopt)(CURL *, CURLoption, ...) = dlsym(libcurl_handle, "curl_easy_setopt");
    void (*curl_easy_cleanup)(CURL *) = dlsym(libcurl_handle, "curl_easy_cleanup");
    void (*curl_global_cleanup)(void) = dlsym(libcurl_handle, "curl_global_cleanup");
    const char* (*curl_easy_strerror)(CURLcode) = dlsym(libcurl_handle, "curl_easy_strerror");

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, post_data);

        res = curl_easy_perform(curl);

        if(res != CURLE_OK) {
            elog(ERROR, "Ошибка при отправке сообщения в Telegram: %s", curl_easy_strerror(res));
            curl_easy_cleanup(curl);
            dlclose(libcurl_handle);
            PG_RETURN_BOOL(false);
        }

        curl_easy_cleanup(curl);
    } else {
        elog(ERROR, "Ошибка инициализации CURL");
        dlclose(libcurl_handle);
        PG_RETURN_BOOL(false);
    }

    curl_global_cleanup();
    dlclose(libcurl_handle);
    PG_RETURN_BOOL(true);
}
