#!/bin/sh
set -ex
curl -O https://download.libsodium.org/libsodium/releases/libsodium-1.0.0.tar.gz
tar xzf libsodium-1.0.0.tar.gz
cd libsodium-1.0.0/
./configure
make && sudo make install && sudo ldconfig
