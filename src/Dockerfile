FROM centos:7
MAINTAINER shr386.docker@outlook.com

ENV PATH=/opt/transmission/bin:/usr/lib64/ccache:$PATH
ENV CCACHE_DIR=/opt/transmission/src/.ccache

RUN yum update -y -q
RUN yum -y -q install gcc gcc-c++ make curl wget tar autoconf automake ccache
RUN yum -y -q install openssl-devel

WORKDIR /src

CMD /bin/bash /src/build.sh
