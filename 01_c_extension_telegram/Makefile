MODULES = pg_tg_sender_onionctchenko

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

override CFLAGS += -Wall -O2 -I. -I$(shell $(PG_CONFIG) --includedir-server)
override SHLIB_LINK += -L/usr/lib/x86_64-linux-gnu -lcurl
override LDFLAGS += -L/usr/lib/x86_64-linux-gnu -lcurl
