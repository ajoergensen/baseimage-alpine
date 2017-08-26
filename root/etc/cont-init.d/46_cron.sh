#!/usr/bin/with-contenv bash
shopt -s nocasematch
if [[ $DEBUG == "true" ]]
 then
	set -x
fi

: ${DISABLE_CRON:="true"}

if [[ $DISABLE_CRON == "true" ]]
 then
	rm -rf /etc/services.d/fcron
	exit 0
fi
