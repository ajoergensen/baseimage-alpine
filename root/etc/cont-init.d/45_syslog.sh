#!/usr/bin/with-contenv bash

: ${DISABLE_SYSLOG:="FALSE"}

if [[ $DISABLE_SYSLOG == "TRUE" ]]
 then
	rm -rf /etc/services.d/rsyslog
fi
