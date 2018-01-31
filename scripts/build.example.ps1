#!/usr/bin/env pwsh

Remove-Item build -Force -Recurse -ErrorAction SilentlyContinue
New-Item -Path .\build -ItemType directory -Force
Set-Location build

#dynamically linked
#cmake -G "Visual Studio 15" "-DCMAKE_TOOLCHAIN_FILE=$env:WORKSPACE\sysconfig\cmake\supertoolchain.cmake" "-DCMAKE_BUILD_TYPE=Release" ..

#statically linked
cmake -G "Visual Studio 15" "-DCMAKE_TOOLCHAIN_FILE=$env:WORKSPACE\sysconfig\cmake\supertoolchain.cmake" "-DVCPKG_TARGET_TRIPLET=x86-windows-static" "-DCMAKE_BUILD_TYPE=Release" ..

cmake --build . --config Release

Set-Location ..
