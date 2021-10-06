#!/bin/bash
set -euo pipefail

cd /opt/app

[ -d server ] || (
	git clone https://github.com/gotify/server
	cd server
	make download-tools
	go get -d
)
cd server

# Build the UI
cd ui
yarn
yarn build
cd ..

# Build the server
export LD_FLAGS="-w -s -X main.Version=$(git describe --tags | cut -c 2-) -X main.Commit=$(git rev-parse --verify HEAD) -X main.Mode=prod";
go run hack/packr/packr.go
go build \
	-ldflags "$LD_FLAGS" \
	-o /opt/app/gotify
