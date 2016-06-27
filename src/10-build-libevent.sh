#!/bin/sh

#libtoolize --force && \
#aclocal && \
#autoheader && \
#automake --force-missing --add-missing && \
#autoconf && \

sh configure --prefix=/opt/transmission --enable-static && \
make && \
make install
