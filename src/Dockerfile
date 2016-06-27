FROM rhee/unpam-centos-6
MAINTAINER shr386.docker@outlook.com

#ENV PATH=/opt/transmission/bin:/usr/lib64/ccache:$PATH
#ENV CCACHE_DIR=/opt/transmission/src/.ccache

RUN yum update -y -q
RUN yum -y -q install gcc gcc-c++ make curl wget tar autoconf automake libtool texinfo
RUN yum -y -q install pcre-devel libssh-devel zlib-devel openssl-devel

#WORKDIR /src
#CMD /bin/bash /src/build.sh

ADD ./ /src/

#CMD /bin/bash

WORKDIR /src/libevent-2.0.22-stable
RUN sh  /src/10-build-libevent.sh

WORKDIR /src/libidn-1.28
RUN sh  /src/20-build-libidn.sh

WORKDIR /src/libnatpmp-20150609
RUN sh  /src/40-build-libnatpmp.sh

WORKDIR /src/curl-7.37.0
RUN sh  /src/80-build-libcurl.sh

WORKDIR /src/transmission-2.84-nofdlimit
RUN sh  /src/99-build-transmission.sh

#CMD tar cvzf /out/_opt-transmission.tar.gz -C / opt/transmission/share opt/transmission/bin opt/transmission/lib
