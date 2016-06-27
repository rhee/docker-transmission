#!/usr/bin/make

MAKEFILE:=$(lastword $(MAKEFILE_LIST))

export CONTAINER=transmission
export OWNER=rhee
export IMAGE=transmission

build:	.FORCE
	mkdir -p out opt
	docker build -t $$IMAGE-builder src
	#docker run --name=$$CONTAINER-builder --rm \
	#	-v $$PWD/out:/out \
	#	$$IMAGE-builder
	-docker rm $$CONTAINER-builder
	docker create --name=$$CONTAINER-builder $$IMAGE-builder
	mkdir -p tmp
	docker cp $$CONTAINER-builder:/opt/transmission tmp/transmission
	docker build -t $$OWNER/$$IMAGE .

#--net=host

export VARDIR  := $(HOME)/Downloads/transmission

rerun:	unrun run

umrun:
	docker rm -f $$CONTAINER

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
		$$OWNER/$$IMAGE
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

.FORCE:
.PHONY:	.FORCE build _build run rm logs bash unrun rerun
