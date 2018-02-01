#!/usr/bin/env pwsh

Remove-Item build -Force -Recurse -ErrorAction SilentlyContinue
New-Item -Path .\build -ItemType directory -Force
Set-Location build

cmake -G "Visual Studio 15" "-DCMAKE_TOOLCHAIN_FILE=$env:VCPKG_ROOT\scripts\buildsystems\vcpkg.cmake" "-DCMAKE_BUILD_TYPE=Release" ..

cmake --build . --config Release

Set-Location ..
