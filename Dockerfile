FROM centos:7
MAINTAINER shr386.docker@outlook.com

ENV RPC_PORT=9091
ENV PORT=58080
ENV VARDIR=/var/lib/transmission-daemon

EXPOSE ${RPC_PORT}
EXPOSE ${PORT}
EXPOSE ${PORT}/udp
VOLUME [ ${VARDIR} ]

ADD opt-transmission-2.82-shr-20160308.tar.gz /

ENV PATH=/opt/transmission/bin:$PATH
ENV LD_LIBRARY_PATH=/opt/transmission/lib:$LD_LIBRARY_PATH

RUN mkdir -p \
  ${VARDIR}/info \
  ${VARDIR}/info/torrents \
  ${VARDIR}/info/resume \
  ${VARDIR}/info/blocklists \
  ${VARDIR}/incoming \
  ${VARDIR}/incomplete \
  ${VARDIR}/downloads \
  ${VARDIR}/logs

RUN rm -fv ${VARDIR}/logs/transmission.log

RUN /opt/transmission/bin/transmission-daemon \
	-f \
	-w ${VARDIR}/downloads \
	--incomplete-dir ${VARDIR}/incomplete \
	--watch-dir ${VARDIR}/incoming \
	-g ${VARDIR}/info \
	-e ${VARDIR}/logs/transmission.log \
	-a '*.*.*.*' \
        -P ${PORT}
	-T

ENTRYPOINT [ "/bin/sh" ]
CMD [ "-c", "/bin/tail -F ${VARDIR}/logs/transmission.log" ]
