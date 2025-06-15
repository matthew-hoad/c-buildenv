source = ./dist
dest ?= ~/.local
repo ?= ''

install:
	@for item in $$(find $(source) -type d) ; do install $${item} -d $(dest)$${item#$(source)} ; done
	@for item in $$(find $(source) -type f) ; do install $${item} $(dest)$${item#$(source)} ; done

podman-build:
	@install -d ./dist
	@podman build -t buildenv -f Dockerfile .
	@podman run --rm -it -e 'REPO=${repo}' -v ./dist:/dist:Z -v ${PWD}/packages.txt:/packages.txt:Z buildenv ./build.sh

podman-shell:
	@install -d ./dist
	@podman build -t buildenv -f Dockerfile .
	@podman run --rm -it -e 'REPO=${repo}' -v ./dist:/dist:Z -v ${PWD}/packages.txt:/packages.txt:Z buildenv /bin/bash

podman-build-install: build-podman install

docker-build:
	@install -d ./dist
	@docker build -t buildenv -f Dockerfile .
	@docker run --rm -e 'REPO=${repo}' -v ./dist:/dist:Z -v ${PWD}/packages.txt:/packages.txt:Z buildenv ./build.sh

docker-shell:
	@install -d ./dist
	@docker build -t buildenv -f Dockerfile .
	@docker run --rm -e 'REPO=${repo}' -v ./dist:/dist:Z -v ${PWD}/packages.txt:/packages.txt:Z buildenv /bin/bash

docker-build-install: build-docker install

tar-dist: build-podman
	@install -d release
	@tar -czvf release/dist.tar.gz dist

.PHONY: install podman-build podman-shell podman-build-install docker-build docker-shell docker-build-install tar-dist
