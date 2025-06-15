source = ./dist
dest ?= ~/.local
clone_url ?= ''

.PHONY: install
install:
	@for item in $$(find $(source) -type d) ; do install $${item} -d $(dest)$${item#$(source)} ; done
	@for item in $$(find $(source) -type f) ; do install $${item} $(dest)$${item#$(source)} ; done


.PHONY: build-podman
build-podman:
	@install -d ./dist
	@podman build -t buildenv -f Dockerfile .
#	@podman run --rm -it -e 'CLONE_URL=${clone_url}' -v ./dist:/dist:Z -v ${PWD}/packages.txt:/packages.txt:Z buildenv /bin/bash
	@podman run --rm -it -e 'CLONE_URL=${clone_url}' -v ./dist:/dist:Z -v ${PWD}/packages.txt:/packages.txt:Z buildenv ./build.sh

.PHONY: podman-build-install
podman-build-install: build-podman install

.PHONY: build-docker
build-docker:
	@install -d ./dist
	@docker build -t buildenv -f Dockerfile .
	@docker run --rm -e 'CLONE_URL=${clone_url}' -v ./dist:/dist:Z -v ${PWD}/packages.txt:/packages.txt:Z buildenv ./build.sh

.PHONY: docker-build-install
docker-build-install: build-docker install

.PHONY: tar-dist
tar-dist: build-podman
	@install -d release
	@tar -czvf release/dist.tar.gz dist
