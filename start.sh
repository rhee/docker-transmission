#!/bin/sh

mkdir -p \
    "$VARDIR/info" \
    "$VARDIR/info/torrents" \
    "$VARDIR/info/resume" \
    "$VARDIR/info/blocklists" \
    "$VARDIR/incoming" \
    "$VARDIR/incomplete" \
    "$VARDIR/downloads" \
    "$VARDIR/logs"

# 이걸 해 봤지만, 리눅스 호스트에 도커에서는 의미 있을 수 있지만,
# docker-machine 기반으로 쓰는 맥 에서는 UID 가 1000 으로 바뀌어
# 들어오기 때문에 소용 없다. 그렇다고 1000 으로 하드코딩을 하긴
# 좀 그렇고.. ?

if [ ! -z "$EUID" ]; then

    useradd --home "$VARDIR" --shell /bin/bash --uid "$EUID" transmission || \
    usermod --home "$VARDIR" --shell /bin/bash --uid "$EUID" transmission

    chown -R transmission \
	"$VARDIR/info" \
	"$VARDIR/info/torrents" \
	"$VARDIR/info/resume" \
	"$VARDIR/info/blocklists" \
	"$VARDIR/incoming" \
	"$VARDIR/incomplete" \
	"$VARDIR/downloads" \
	"$VARDIR/logs"

    exec su transmission -c "/opt/transmission/bin/transmission-daemon  -f  -w '$VARDIR/downloads'  --incomplete-dir '$VARDIR/incomplete'  --watch-dir '$VARDIR/incoming'  -g '$VARDIR/info'  -a '*.*.*.*'  -p 9091  -P 51413  -m  -T" 

fi

exec transmission-daemon \
	-f \
	-w "$VARDIR/downloads" \
	--incomplete-dir "$VARDIR/incomplete" \
	--watch-dir "$VARDIR/incoming" \
	-g "$VARDIR/info" \
	-a '*.*.*.*' \
	-p 9091 \
	-P 51413 \
	-m \
	-T
