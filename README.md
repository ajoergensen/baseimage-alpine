Alpine baseimage
================

A baseimage based on Alpine 3.6 with s6 init.

Bits and pieces have been sourced from other fine Docker images

#### Environment

 `PUID` - Changes the uid of the app user, default 911
 `PGID` - Changes the gid of the app group, default 911
 `SMTP_HOST` - Change the SMTP relay server used by ssmtp (sendmail) 
 `SMTP_USER` - Username for the SMTP relay server
 `SMTP_PASS` - Password for the SMTP relay server
 `SMTP_PORT` - Outgoing SMTP port, default 587
 `SMTP_SECURE` - Does the SMTP server requires a secure connection, default TRUE
 `SMTP_TLS` - Use STARTTLS, default TRUE (if SMTP_TLS is FALSE and SMTP_SECURE is true, SMTP over SSL will be used)
 `SMTP_MASQ` - Masquerade outbound emails using this domain, default empty

#### Persistent data

Generally I store configuration data in /config and store it in a volume. If an application does not permit changing the location of its configuration data, add a script to `/etc/cont-init.d` which changes the app user's $HOME

