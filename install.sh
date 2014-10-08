#!/bin/sh
sudo apt-get build-dep libzmq3-dev libzmq1
sudo apt-get -y install build-essential automake autoconf

git clone git://github.com/jedisct1/libsodium.git
cd libsodium
./autogen.sh
./configure && make check
sudo make install
sudo ldconfig
cd ..

git clone git://github.com/zeromq/libzmq.git
cd libzmq
./autogen.sh
./configure && make check
sudo make install
sudo ldconfig
cd ..

git clone git://github.com/zeromq/czmq.git
cd czmq
./autogen.sh
./configure && make check
sudo make install
sudo ldconfig
cd ..

