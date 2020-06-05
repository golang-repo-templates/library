.DEFAULT_GOAL := help

.PHONY: all
all: ## full build
all: clean install build fmt lint test release

.PHONY: dev
dev: ## fast build
dev: build fmt lint-fast test

.PHONY: clean
clean: ## go clean
	$(call print-target)
	go clean -r -i -cache -testcache -modcache

.PHONY: install
install: ## install build tools
	$(call print-target)
	./install.sh

.PHONY: build
build: ## go build
	$(call print-target)
	go build ./...

.PHONY: fmt
fmt: ## goimports
	$(call print-target)
	goimports -l -w .

.PHONY: lint
lint: ## golangci-lint
	$(call print-target)
	golangci-lint run

.PHONY: lint-fast
lint-fast: ## golangci-lint --fast
	$(call print-target)
	golangci-lint run --fast

.PHONY: test
test: ## go test with race detector and code covarage
	$(call print-target)
	go test -race -covermode=atomic ./...

.PHONY: release
release: ## goreleaser --snapshot --skip-publish --rm-dist
	$(call print-target)
	goreleaser --snapshot --skip-publish --rm-dist

.PHONY: publish
publish:
	$(call print-target)
	@test -n "$(CI)" || (echo "$@ should be running only on CI Server" && exit 1)
	goreleaser --rm-dist

.PHONY: docker
docker: ## run in golang container, example: make docker run="make all"
	docker run --rm -v $(CURDIR):/app golang:1.14 $(args) sh -c "cd /app && $(run)"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

define print-target
    @printf "Executing target: \033[36m$@\033[0m\n"
endef
