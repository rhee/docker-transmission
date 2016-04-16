#!/bin/sh

mkdir -p \
	"${VARDIR}/info" \
	"${VARDIR}/info/torrents" \
	"${VARDIR}/info/resume" \
	"${VARDIR}/info/blocklists" \
	"${VARDIR}/incoming" \
	"${VARDIR}/incomplete" \
	"${VARDIR}/downloads" \
	"${VARDIR}/logs"

exec transmission-daemon \
	-f \
	-w "${VARDIR}/downloads" \
	--incomplete-dir "${VARDIR}/incomplete" \
	--watch-dir "${VARDIR}/incoming" \
	-g "${VARDIR}/info" \
	-a '*.*.*.*' \
	-p "${RPCPORT}" \
	-P "${PORT}" \
	-m \
	-T
