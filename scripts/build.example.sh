#!/bin/bash

mkdir -p build
cd build
cmake "-DCMAKE_TOOLCHAIN_FILE=$env:WORKSPACE\sysconfig\cmake\supertoolchain.cmake" "-DCMAKE_BUILD_TYPE=Release" ..
cmake --build .
cd ..
