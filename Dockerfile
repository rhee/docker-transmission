from centos:7
maintainer shr386.docker@outlook.com

ARG rpc_port=9091
#ARG port=51413
ARG port=58080

EXPOSE ${rpc_port}
EXPOSE ${port}
EXPOSE ${port}/udp

volume [ "/opt/transmission/var/lib/transmission-daemon" ]

add opt-transmission-2.82-shr-20160308.tar.gz /

entrypoint [ "/bin/sh" ]

cmd [ "/opt/transmission/bin/start-transmission-daemon.sh" ]
