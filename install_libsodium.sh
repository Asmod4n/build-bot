#!/bin/sh
set -ex
gpg --recv-keys 1CDEA439
curl -O https://download.libsodium.org/libsodium/releases/libsodium-1.0.0.tar.gz
curl -O https://download.libsodium.org/libsodium/releases/libsodium-1.0.0.tar.gz.sig
gpg --verify libsodium-1.0.0.tar.gz.sig || exit
tar xzf libsodium-1.0.0.tar.gz
cd libsodium-1.0.0/
./configure
make check && sudo make install && sudo ldconfig
