#!/bin/sh

mkdir -p \
    "/opt/transmission/var/info" \
    "/opt/transmission/var/info/torrents" \
    "/opt/transmission/var/info/resume" \
    "/opt/transmission/var/info/blocklists" \
    "/opt/transmission/var/incoming" \
    "/opt/transmission/var/incomplete" \
    "/opt/transmission/var/downloads" \
    "/opt/transmission/var/logs"

# 이걸 해 봤지만, 리눅스 호스트에 도커에서는 의미 있을 수 있지만,
# docker-machine 기반으로 쓰는 맥 에서는 UID 가 1000 으로 바뀌어
# 들어오기 때문에 소용 없다. 그렇다고 1000 으로 하드코딩을 하긴
# 좀 그렇고.. ?

if [ ! -z "$EUID" ]; then

    useradd --home "/opt/transmission/var" --shell /bin/bash --uid "$EUID" transmission || \
    usermod --home "/opt/transmission/var" --shell /bin/bash --uid "$EUID" transmission

    chown -R transmission \
	"/opt/transmission/var/info" \
	"/opt/transmission/var/info/torrents" \
	"/opt/transmission/var/info/resume" \
	"/opt/transmission/var/info/blocklists" \
	"/opt/transmission/var/incoming" \
	"/opt/transmission/var/incomplete" \
	"/opt/transmission/var/downloads" \
	"/opt/transmission/var/logs"

    exec su transmission -c "/opt/transmission/bin/transmission-daemon  -f  -w '/opt/transmission/var/downloads'  --incomplete-dir '/opt/transmission/var/incomplete'  --watch-dir '/opt/transmission/var/incoming'  -g '/opt/transmission/var/info'  -a '*.*.*.*'  -p 9091  -P 51413  -m  -T" 

fi

exec transmission-daemon \
	-f \
	-w "/opt/transmission/var/downloads" \
	--incomplete-dir "/opt/transmission/var/incomplete" \
	--watch-dir "/opt/transmission/var/incoming" \
	-g "/opt/transmission/var/info" \
	-a '*.*.*.*' \
	-p 9091 \
	-P 51413 \
	-m \
	-T
