FROM centos:7
MAINTAINER shr386.docker@outlook.com

ADD opt-transmission-2.82-shr-20160308.tar.gz /
COPY start.sh /

COPY help /
RUN chmod +x /help

ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

ENV RPCPORT=9091
ENV PORT=51413
ENV VARDIR=/var/lib/transmission-daemon

EXPOSE ${RPCPORT}
EXPOSE ${PORT}
EXPOSE ${PORT}/udp
VOLUME ${VARDIR}

ENV PATH=/opt/transmission/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/transmission/lib:$LD_LIBRARY_PATH

#ENTRYPOINT [ "/bin/sh" ]
#CMD [ "/start.sh" ]

CMD [ "/usr/local/bin/dumb-init", "/start.sh" ]
