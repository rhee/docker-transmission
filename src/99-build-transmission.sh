#!/bin/sh
aclocal
automake
CFLAGS=-I/opt/transmission/include \
LDFLAGS=-L/opt/transmission/lib \
LIBEVENT_CFLAGS=-I/opt/transmission/include \
LIBEVENT_LIBS=/opt/transmission/lib/libevent.a \
LIBCURL_CFLAGS=-I/opt/transmission/include \
LIBCURL_LIBS=/opt/transmission/lib/libcurl.a \
sh configure \
--prefix=/opt/transmission \
--enable-cli \
--enable-daemon \
--without-gtk \
--enable-silent-rules \
--enable-utp \
--enable-external-natpmp \
--disable-nls \
&& make \
&& make install
