#!/usr/bin/make

MAKEFILE:=$(lastword $(MAKEFILE_LIST))

export CONTAINER=transmission
export IMAGE=rhee/transmission

build:
	$(MAKE) -f $(MAKEFILE) _build 2>&1 | tee -a build.log

_build:
	mkdir -p out opt
	docker build -t $$IMAGE-builder src
	docker run --name=$$CONTAINER-builder --rm \
		-u $$(id -u):$$(id -g) \
		-v $$PWD/out:/out \
		-v $$PWD/opt:/opt \
		-v $$PWD/src:/src \
		$$IMAGE-builder
	docker build -t $$IMAGE .

#--net=host

export VARDIR  := $(HOME)/Downloads/transmission

run:	nat
	mkdir -p "$$VARDIR"
	docker run --name=$$CONTAINER \
		--restart=unless-stopped \
		-e VARDIR=$$VARDIR \
		-v $$VARDIR:$$VARDIR \
		-u $$(id -u):$$(id -g) \
		-p 9091:9091 \
		-p 51413:51413 \
		-p 51413:51413/udp \
		-d \
		$$IMAGE
	docker exec $$CONTAINER transmission-remote -P

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
