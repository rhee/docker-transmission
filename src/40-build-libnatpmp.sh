#!/bin/sh

#sh configure --prefix=/opt/transmission --enable-static \
#&& make \
#&& make install

make INSTALLPREFIX=/opt/transmission all install

