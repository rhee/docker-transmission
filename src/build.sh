#!/bin/sh
( cd libevent-2.0.22-stable ; sh ../10-build-libevent.sh )
( cd libidn-1.28 ; sh ../20-build-libidn.sh )
( cd libnatpmp-20150609 ; sh ../40-build-libnatpmp.sh )
( cd curl-7.37.0 ; sh ../80-build-libcurl.sh )
( cd transmission-2.84-nofdlimit ; sh ../99-build-transmission.sh )
