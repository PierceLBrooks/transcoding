#!/bin/sh
rm -rf $PWD/build
rm -rf $PWD/install
mkdir -p $PWD/build
cd $PWD/build
cmake -DCMAKE_INSTALL_PREFIX=../install ..
cmake --build . --target install

