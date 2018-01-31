# supertoolchain.cmake

set(VCPKG_CHAINLOAD_TOOLCHAIN_FILE $ENV{WORKSPACE}/sysconfig/cmake/physycom_toolchain.cmake)
include($ENV{WORKSPACE}/vcpkg/scripts/buildsystems/vcpkg.cmake)
