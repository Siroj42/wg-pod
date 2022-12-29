SHELL := /bin/sh

build:
	CGO_ENABLED=0 go build

build-arm:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build
