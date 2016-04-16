FROM centos:7
MAINTAINER shr386.docker@outlook.com

ENV RPCPORT=9091
ENV PORT=58080
ENV VARDIR=/var/lib/transmission-daemon

EXPOSE ${RPCPORT}
EXPOSE ${PORT}
EXPOSE ${PORT}/udp
VOLUME ${VARDIR}

ADD opt-transmission-2.82-shr-20160308.tar.gz /
ADD start.sh /
ADD help /

RUN chmod +x /help

ENV PATH=/opt/transmission/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/transmission/lib:$LD_LIBRARY_PATH

ENTRYPOINT [ "/bin/sh" ]
CMD [ "/start.sh" ]
