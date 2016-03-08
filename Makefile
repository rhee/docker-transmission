#!/usr/bin/make

export RPC_PORT:=9091
#export PORT:=51413
export PORT:=58080

build:	.FORCE
	docker build -t rhee/transmission .

run:	.FORCE
	docker run --name=transmission -d \
		-p $$RPC_PORT:$$RPC_PORT \
		-p $$PORT:$$PORT \
		-p $$PORT:$$PORT/udp \
		-v ~/Downloads/transmission:/opt/transmission/var/lib/transmission-daemon rhee/transmission

unrun:	.FORCE
	-docker kill transmission
	-docker rm transmission

unnat:	.FORCE
	-VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 delete tcp-$$RPC_PORT
	-VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 delete tcp-$$PORT
	-VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 delete udp-$$PORT

nat:	.FORCE
	-VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 tcp-$$RPC_PORT,tcp,,$$RPC_PORT,,$$RPC_PORT
	-VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 tcp-$$PORT,tcp,,$$PORT,,$$PORT
	-VBoxManage controlvm $$DOCKER_MACHINE_NAME natpf1 udp-$$PORT,udp,,$$PORT,,$$PORT

showconfig:	.FORCE
	@echo PORT=$$PORT RPC_PORT=$$RPC_PORT DOCKER_MACHINE_NAME=$$DOCKER_MACHINE_NAME

.FORCE:
.PHONY:	build
