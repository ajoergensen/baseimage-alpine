#!/usr/bin/with-contenv bash

CONF="/etc/ssmtp/ssmtp.conf"
: ${SMTP_HOST:="smtp.example.host"}
: ${SMTP_USER:=''}
: ${SMTP_PASS:=''}
: ${SMTP_PORT:='587'}
: ${SMTP_SECURE:=''}
: ${SMTP_TLS:='TRUE'}
: ${SMTP_MASQ:='example.host'}

SMTP_SECURE=$(echo $SMTP_SECURE | tr '[A-Z]' '[a-z]')
SMTP_TLS=$(echo $SMTP_TLS | tr '[A-Z]' '[a-z]')

cat > $CONF <<EOF
MailHub=$SMTP_HOST:$SMTP_PORT
FromLineOverride=YES
Hostname=$SMTP_MASQ
RewriteDomain=$SMTP_MASQ
AuthUser=$SMTP_USER
AuthPass=$SMTP_PASS
TLS_CA_Dir=/usr/share/ca-certificates
EOF

shopt -s nocasematch
if [[ ! -z $SMTP_USER ]] || [[ $SMTP_SECURE == "true" ]]
 then
	: ${SMTP_SECURE:='TRUE'}
	if [[ $SMTP_SECURE == "TRUE" ]]
	 then
		echo "UseTLS=Yes" >> $CONF
	 else
		echo "UseTLS=No" >> $CONF
	fi

	if [[ $SMTP_SECURE == "true" && $SMTP_TLS = "true" ]]
	 then
		echo "UseSTARTTLS=Yes" >> $CONF
	 else
		echo "UseSTARTTLS=No" >> $CONF
	fi
 else
	echo "UseTLS=No" >> $CONF
	echo "UseSTARTTLS=No" >> $CONF
fi
