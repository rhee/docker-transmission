#!/usr/bin/make

MAKEFILE:=$(lastword $(MAKEFILE_LIST))

export CONTAINER=transmission
export IMAGE=rhee/transmission

build:
	mkdir -p /tmp/$$(id -u)
	$(MAKE) -f $(MAKEFILE) _build 2>&1 | tee -a /tmp/$$(id -u)/$$CONTAINER-build.log

_build:
	mkdir -p out
	docker build -t $$IMAGE-builder src
	docker run --name=$$CONTAINER-builder --rm \
		-v $$PWD/out:/out \
		$$IMAGE-builder
	docker build -t $$IMAGE .

#--net=host

export VARDIR  := $(HOME)/Downloads/transmission

rerun:	unrun run

umrun:
	docker rm -f $$CONTAINER

#		-u $$(id -u):$$(id -g) \
# 리눅스 호스트 도커에서는
# -e EUID=$$(id -u)
# docker-machine 기반 맥 도커에서는
# -e EUID=1000

run:	nat
	mkdir -p "$$VARDIR"
	docker run --name=$$CONTAINER \
		--restart=unless-stopped \
		-e EUID=1000 \
		-e VARDIR=$$VARDIR \
		-v $$VARDIR:$$VARDIR \
		-p 9091:9091 \
		-p 51413:51413 \
		-p 51413:51413/udp \
		-d \
		$$IMAGE
	sleep 5 && docker exec $$CONTAINER /opt/transmission/bin/transmission-remote -P

rm:	unnat
	-docker kill $$CONTAINER
	-docker rm -f $$CONTAINER

nat:
	-if [ ! -z "$$DOCKER_MACHINE_NAME" ]; \
	then \
	    VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 tcp-9091,tcp,,9091,,9091 ; \
	    VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 tcp-51413,tcp,,51413,,51413 ; \
	    VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 udp-51413,udp,,51413,,51413 ; \
	fi

unnat:
	-if [ ! -z "$$DOCKER_MACHINE_NAME" ]; \
	    VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 delete tcp-9091 ; \
	    VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 delete tcp-51413 ; \
	    VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 delete udp-51413 ; \
	fi

.PHONY:	build _build run rm logs bash unrun rerun
