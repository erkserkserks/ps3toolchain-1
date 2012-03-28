#!/bin/sh
# newlib-1.19.0-SPU.sh by Dan Peori (dan.peori@oopo.net)

## Download the source code.
wget --continue ftp://sources.redhat.com/pub/newlib/newlib-1.19.0.tar.gz || { exit 1; }

## Unpack the source code.
rm -Rf newlib-1.19.0 && tar xfvz newlib-1.19.0.tar.gz && cd newlib-1.19.0 || { exit 1; }

## Patch the source code.
cat ../../patches/newlib-1.19.0-PS3.patch | patch -p1 || { exit 1; }

## Create the build directory.
mkdir build-spu && cd build-spu || { exit 1; }

## Configure the build.
../configure --prefix="$PS3DEV/host/spu" --target="spu" \
    --enable-newlib-multithread \
    --enable-newlib-hw-fp \
    || { exit 1; }

## Compile and install.
make ${PARALLEL} && make install || { exit 1; }
