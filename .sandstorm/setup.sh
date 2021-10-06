#!/bin/bash

# When you change this file, you must take manual action. Read this doc:
# - https://docs.sandstorm.io/en/latest/vagrant-spk/customizing/#setupsh

set -euo pipefail

version=1.17.1
os=linux
arch=amd64

# The version of golang in the debian repositories tends to be incredibly
# out of date; let's get ourselves a newer version from upstream:
curl -L https://golang.org/dl/go${version}.${os}-${arch}.tar.gz -o go.tar.gz
tar -C /usr/local -xzf go.tar.gz
rm go.tar.gz
echo 'export PATH=/usr/local/go/bin:$PATH' > /etc/profile.d/go.sh

apt-get install -y \
	git `# Needed for fetching go libraries.` \
	build-essential `# Needed for cgo` \
	apt-transport-https `# Needed for node install below.`

curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
npm install -g yarn

exit 0
