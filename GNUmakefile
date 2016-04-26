#!/usr/bin/make

DOCKER_MACHINE_NAME := $(DOCKER_MACHINE_NAME)

RPCPORT := 9091
PORT    := 51413
VARDIR  := $(HOME)/Downloads/transmission

build:	.FORCE
	docker build -t rhee/transmission .

#--net=host
#-u $$(id -u):$$(id -g)

run:	.FORCE
	mkdir -p "$(VARDIR)"
	docker run --name=transmission \
		--restart=unless-stopped \
		--net=host \
		-e VARDIR=$(VARDIR) \
		-p 9091:9091 \
		-p 51413:51413 \
		-p 51413:51413/udp \
		-v $(VARDIR):$(VARDIR) \
		-d \
		rhee/transmission
	docker exec transmission transmission-remote -P

rm:	.FORCE
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
