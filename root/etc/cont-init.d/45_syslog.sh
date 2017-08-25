#!/usr/bin/with-contenv bash
shopt -s nocasematch
if [[ $DEBUG == "TRUE" ]]
 then
	set -x
fi

: ${DISABLE_SYSLOG:="FALSE"}
: ${REMOTE_SYSLOG_HOST:="FALSE"}
: ${REMOTE_SYSLOG_PORT:="514"}
: ${REMOTE_SYSLOG_PROTO:="tcp"}

if [[ $DISABLE_SYSLOG == "TRUE" ]]
 then
	rm -rf /etc/services.d/rsyslog
	exit 0
fi

if [[ $REMOTE_SYSLOG_HOST != "FALSE" ]]
 then
	case $REMOTE_SYSLOG_PROTO in
        	udp)
			PROTO="@@"
        	;;
        	tcp)
			PROTO="@"
        	;;
        	*)
                	echo "unsupported option $REMOTE_SYSLOG_PROTO, defaulting to tcp"
			PROTO="@"	
        	;;
	esac
	shopt -u nocasematch

	cat > /etc/rsyslog.d/remote.conf <<EOF
\$WorkDirectory /var/spool/rsyslog # where to place spool files
\$ActionQueueFileName uniqName # unique name prefix for spool files
\$ActionQueueMaxDiskSpace 1g   # 1gb space limit (use as much as possible)
\$ActionQueueSaveOnShutdown on # save messages to disk on shutdown
\$ActionQueueType LinkedList   # run asynchronously
\$ActionResumeRetryCount -1    # infinety retries if host is down
\$ActionResumeInterval 30      # retry interval
# remote host is: name/ip:port, e.g. 192.168.0.1:514, port optional
*.* ${PROTO}${REMOTE_SYSLOG_HOST}:${REMOTE_SYSLOG_PORT}
EOF

	mkdir -p /var/spool/rsyslog
fi
