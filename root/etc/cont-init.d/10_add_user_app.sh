#!/usr/bin/with-contenv bash
set -x

if [ ! -z "$PUID" ]
 then
        if [ ! "$(id -u app)" -eq "$PUID" ]; then usermod -o -u "$PUID" app ; fi
fi

if [ ! -z "$PGID" ]
 then
        if [ ! "$(id -g app)" -eq "$PGID" ]; then groupmod -o -g "$PGID" app ; fi
fi

echo "
-----------------------------------
GID/UID
-----------------------------------
User uid:    $(id -u app)
User gid:    $(id -g app)
-----------------------------------
"


chown app:app /app
chown app:app /config
chown app:app /defaults
