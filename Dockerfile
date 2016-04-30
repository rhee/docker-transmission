FROM centos:7
MAINTAINER shr386.docker@outlook.com

ADD out/_opt-transmission.tar.gz /
COPY start.sh /

COPY help /
RUN chmod +x /help

#ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.1/dumb-init_1.0.1_amd64 /dumb-init
COPY dumb-init_1.0.1_amd64 /dumb-init
RUN chmod +x /dumb-init

ENV VARDIR=/transmission

EXPOSE 9091
EXPOSE 51413
EXPOSE 51413/udp
VOLUME ${VARDIR}

ENV PATH=/opt/transmission/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/transmission/lib:$LD_LIBRARY_PATH

CMD [ "/dumb-init", "/start.sh" ]
