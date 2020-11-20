Alpine baseimage
================
**UPDATE** 2018-10-07 - Possible breakage! I have decided to switch back to using [tagged repositories](https://wiki.alpinelinux.org/wiki/Alpine_Linux_package_management#Repository_pinning). This means you may have to add @repotag to packages not in the main repositories. repo-tags are: `@edge`, `@edgecommunity` and `@testing`

**UPDATE** 2018-11-23 - fcron has been removed. If you need a cron daemon, install it.

**UPDATE** 2020-06-12 - Versions 3.7 and 3.8 removed

A baseimage based on Alpine 3.x with [Skarnet's s6 process supervision](http://www.skarnet.org/software/s6/) installed from [Just Container's s6 Overlay](https://github.com/just-containers/s6-overlay).

Bits and pieces have been sourced from other fine Docker images

#### Tags

Use `ajoergensen/baseimage-alpine:3.X` where X is either 9, 10, 11 or 12

#### Environment

- `PUID` - Changes the uid of the app user, default 911
- `PGID` - Changes the gid of the app group, default 911
- `DISABLE_CRON` - Do not run cron. Default is TRUE
- `DISABLE_SYSLOG` - If set to TRUE, do not run rsyslog inside the container. Default is FALSE
- `REMOTE_SYSLOG_HOST` - If you want to log to a remote syslog server, set this variable to the IP or DNS name of the server. Remote logging is off by default.
- `REMOTE_SYSLOG_PORT` - Port used by the remote syslog server. Default is 514
- `REMOTE_SYSLOG_PROTO` - Protocol to use for the remote syslog server. Possible values are tcp or udp, default is tcp.
- `SMTP_HOST` - Change the SMTP relay server used by ssmtp (sendmail) 
- `SMTP_USER` - Username for the SMTP relay server
- `SMTP_PASS` - Password for the SMTP relay server
- `SMTP_PORT` - Outgoing SMTP port, default 587
- `SMTP_SECURE` - Does the SMTP server requires a secure connection, default TRUE if SMTP_USER is set.
- `SMTP_TLS` - Use STARTTLS, default TRUE (if SMTP_TLS is FALSE and SMTP_SECURE is true, SMTP over SSL will be used)
- `SMTP_MASQ` - Masquerade outbound emails using this domain, default empty

#### Running applications

It is recommended to run applications as the unpriviledged user `app`.

To run the application, add a start-up script like this

```bash
#/usr/bin/with-contenv bash
exec s6-setuidgid app /path/to/application
```

One shortcoming is the fact `s6-setuidgid` does not set the `$HOME` variable. The work-around looks like this:

```bash
#/usr/bin/with-contenv bash
export HOME="~app"
exec s6-setuidgid app /path/to/application
```

I have looked at the possiblity of adding [setuser](https://github.com/phusion/baseimage-docker/blob/master/image/bin/setuser) from the phusion baseimage but doing requires installing Python 3 which add bloat.

If you want add setuser, create a `Dockerfile` like this:

```
FROM ajoergensen/baseimage-alpine
RUN \
        apk add --no-cache python3 && \
        wget https://raw.githubusercontent.com/phusion/baseimage-docker/master/image/bin/setuser -O /sbin/setuser && \
        chmod +x /sbin/setuser
```

#### Email

If you need to send mail and cannot use SMTP directly, ssmtp is installed to provide `/usr/bin/sendmail` and is configured using the `SMTP_` variables.

If SMTP_USER is not set, unauthenticated SMTP will be used and SSL/TLS is disabled.

#### Persistent data

Generally I store configuration data in /config and store it in a volume. If an application does not permit changing the location of its configuration data, add a script to `/etc/cont-init.d` which changes the app user's $HOME

