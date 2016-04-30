#!/bin/sh

sh configure --prefix=/opt/transmission --enable-static \
&& make \
&& make install

