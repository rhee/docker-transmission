#!/usr/bin/make

DOCKER_MACHINE_NAME := $$DOCKER_MACHINE_NAME

UID := $(shell id -u)
GID := $(shell id -g)

RPCPORT := 9091
PORT    := 58080
VARDIR  := /opt/transmission/var/lib/transmission-daemon

build:	.FORCE
	docker build -t rhee/transmission .

run:	.FORCE
	docker run --name=transmission \
		--restart=unless-stopped \
		--net="host" \
		-u $(UID):$(GID) \
		-e RPCPORT=$(RPCPORT) \
		-e PORT=$(PORT) \
		-e VARDIR=$(VARDIR) \
		-p $(RPCPORT):$(RPCPORT) \
		-p $(PORT):$(PORT) \
		-p $(PORT):$(PORT)/udp \
		-v $(VARDIR):$(VARDIR) \
		-d \
		rhee/transmission

stop:	.FORCE
	-docker kill transmission
	-docker rm -f transmission

nat:	.FORCE
	-VBoxManage controlvm $(DOCKER_MACHINE_NAME) natpf1 tcp-$(RPCPORT),tcp,,$(RPCPORT),,$(RPCPORT)
	-VBoxManage controlvm $(DOCKER_MACHINE_NAME) natpf1 tcp-$(PORT),tcp,,$(PORT),,$(PORT)
	-VBoxManage controlvm $(DOCKER_MACHINE_NAME) natpf1 udp-$(PORT),udp,,$(PORT),,$(PORT)

unnat:	.FORCE
	-VBoxManage controlvm $(DOCKER_MACHINE_NAME) natpf1 delete tcp-$(RPCPORT)
	-VBoxManage controlvm $(DOCKER_MACHINE_NAME) natpf1 delete tcp-$(PORT)
	-VBoxManage controlvm $(DOCKER_MACHINE_NAME) natpf1 delete udp-$(PORT)

showconfig:	.FORCE
	@echo PORT=$(PORT) RPCPORT=$(RPCPORT) DOCKER_MACHINE_NAME=$(DOCKER_MACHINE_NAME)

.FORCE:
.PHONY:	build
