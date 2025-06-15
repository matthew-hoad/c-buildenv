#! /bin/bash

apt-get install -y --no-install-recommends $(cat packages.txt)

git clone $CLONE_URL /src
cd /src

make PREFIX="/dist" clean install
