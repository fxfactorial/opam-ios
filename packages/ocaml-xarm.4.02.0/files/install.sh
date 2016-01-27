#!/bin/sh -e

PREFIX="$1"

export XARMTARGET="${PREFIX}"

svn co svn://svn.psellos.com/tags/ocamlxarm-4.0.2 ocamlxarm-4.0 
cd ocamlxarm-4.0

sed -i bak \
    -e \
    's|export XARMTARGET=/usr/local/ocamlxarm|export XARMTARGET='${PREFIX}'|g' \
    xarm-build

sed -i bak \
    -e \
    's|export SDK=/Developer/SDKs/iPhoneOS7.1.sdk|export SDK=/Developer/SDKs/iPhoneOS8.3.sdk|g' \
    xarm-build

sed -i bak \
    -e \
    's|export OSXARCH=i386|export OSXARCH=x86_64|g' \
    xarm-build

sed -i bak \
    -e \
    's|# export ARMARCH=v6|export ARMARCH=v7|g' \
    xarm-build

sh xarm-build all > xarm-build.log

make install

cd ..

sed -i bak -e 's|OCAMLDIR|'${PREFIX}'|g' ocamloptrev
cp ocamloptrev "${PREFIX}/bin"
