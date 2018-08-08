
BUILD_ID ?= ${USER}


.PHONY: builder
builder:
	docker build -t local/arch-build:${BUILD_ID} builder/

target:
	mkdir -p pkgs .ccache

build: builder target
	docker run -ti \
		-v ${PWD}/pkgs:/home/alarm/work \
		-v ${PWD}/.ccache:/home/alarm/.ccache \
		local/arch-build:${BUILD_ID} \
		/bin/bash
