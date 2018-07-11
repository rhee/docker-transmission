FROM alpine:3.4

#RUN apk add --no-cache --virtual .build-deps \
# gcc g++ libc-dev make curl wget tar autoconf automake libtool texinfo \
# libevent-dev pcre-dev libssh-dev zlib-dev openssl-dev && \
# apk add --no-cache libevent pcre libssh squid

RUN apk add --no-cache transmission-cli transmission-daemon

COPY dumb-init_1.0.1_amd64 /dumb-init
RUN chmod +x /dumb-init

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp

VOLUME /opt/transission/var

ENV UID=1000

RUN adduser -D -u $UID user1

RUN mkdir -p \
    /opt/transmission/var/info \
    /opt/transmission/var/info/torrents \
    /opt/transmission/var/info/resume \
    /opt/transmission/var/info/blocklists \
    /opt/transmission/var/incoming \
    /opt/transmission/var/incomplete \
    /opt/transmission/var/downloads \
    /opt/transmission/var/logs && \
 chown -R $UID /opt/transmission/var /opt/transmission/var/*

WORKDIR /opt/transmission/var

CMD [ "/dumb-init", "su", "-c", "exec transmission-daemon -f -w '/opt/transmission/var/downloads' --incomplete-dir '/opt/transmission/var/incomplete' --watch-dir '/opt/transmission/var/incoming' -g '/opt/transmission/var/info' -a '*.*.*.*' -p 9091 -P 51413 -m -T", "user1" ]
