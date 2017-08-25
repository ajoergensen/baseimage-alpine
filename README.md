Alpine baseimage
================

[![](https://images.microbadger.com/badges/image/ajoergensen/baseimage-alpine.svg)](https://microbadger.com/images/ajoergensen/baseimage-alpine "Get your own image badge on microbadger.com") [![Build Status](https://travis-ci.org/ajoergensen/baseimage-alpine.svg?branch=master)](https://travis-ci.org/ajoergensen/baseimage-alpine) [![](https://images.microbadger.com/badges/commit/ajoergensen/baseimage-alpine.svg)](https://microbadger.com/images/ajoergensen/baseimage-alpine "Get your own commit badge on microbadger.com")

A baseimage based on Alpine 3.6 with s6 init.

Bits and pieces have been sourced from other fine Docker images

#### Environment

- `PUID` - Changes the uid of the app user, default 911
- `PGID` - Changes the gid of the app group, default 911
- `DISABLE_SYSLOG` - If set to TRUE, do not run rsyslog inside the container. Default is FALSE
- `REMOTE_SYSLOG_HOST` - If you want to log to a remote syslog server, set this variable to the IP or DNS name of the server. Remote logging is off by default.
- `REMOTE_SYSLOG_PORT` - Port used by the remote syslog server. Default is 514
- `REMOTE_SYSLOG_PROTO` - Protocol to use for the remote syslog server. Possible values are tcp or udp, default is tcp.
- `SMTP_HOST` - Change the SMTP relay server used by ssmtp (sendmail) 
- `SMTP_USER` - Username for the SMTP relay server
- `SMTP_PASS` - Password for the SMTP relay server
- `SMTP_PORT` - Outgoing SMTP port, default 587
- `SMTP_SECURE` - Does the SMTP server requires a secure connection, default TRUE
- `SMTP_TLS` - Use STARTTLS, default TRUE (if SMTP_TLS is FALSE and SMTP_SECURE is true, SMTP over SSL will be used)
- `SMTP_MASQ` - Masquerade outbound emails using this domain, default empty

#### Email

If you need to send mail and cannot use SMTP directly, ssmtp is installed to provide `/usr/bin/sendmail` and is configured using the `SMTP_` variables.

#### Persistent data

Generally I store configuration data in /config and store it in a volume. If an application does not permit changing the location of its configuration data, add a script to `/etc/cont-init.d` which changes the app user's $HOME

