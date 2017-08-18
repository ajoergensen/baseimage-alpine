FROM alpine:3.6
MAINTAINER Allan Willems Joergensen <allan@nowhere.dk>

COPY files/repositories /etc/apk/repositories

ENV LANG='en_US.UTF-8' LANGUAGE='en_US.UTF-8' TERM='xterm' 

RUN \
	apk -U upgrade && \
	apk add busybox-extras bash bash-completion bind-tools ssmtp curl file wget tar ca-certificates shadow tzdata && \
	cp /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime && \
	apk del tzdata && \
	curl -sSL `curl -s https://api.github.com/repos/just-containers/s6-overlay/releases/latest | grep 'browser_' | cut -d\" -f4 | grep "s6-overlay-amd64.tar.gz$"` | tar xvfz - -C / && \
	groupadd -g 911 app && \
	useradd -u 911 -g 911 -s /bin/false -m app && \
        usermod -G users app && \
	mkdir -p /app /config /defaults && \
	rm -rf /var/cache/apk/*

ADD root /

RUN chmod -v +x /etc/cont-init.d/*

VOLUME /config

ENTRYPOINT ["/init"]
CMD []
