#! /bin/bash

apt-get install -y --no-install-recommends $(cat packages.txt)

git clone $REPO /src
cd /src

make PREFIX="/dist" clean install
