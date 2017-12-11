#!/bin/bash

mkdir -p build
cd build
cmake "-DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=${WORKSPACE}\sysconfig\cmake\physycom_toolchain.cmake" "-DCMAKE_BUILD_TYPE=Release" ..
cmake --build . 
cd ..
