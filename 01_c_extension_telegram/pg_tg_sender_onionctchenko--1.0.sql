CREATE OR REPLACE FUNCTION send_to_telegram(bot_token text, chat_id text, message_text text)
RETURNS boolean AS 'MODULE_PATHNAME', 'send_to_telegram'
LANGUAGE C STRICT;
