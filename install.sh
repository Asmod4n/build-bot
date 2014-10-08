#!/bin/sh
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
