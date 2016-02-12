#!/bin/sh -e

prefix="$1"
bits=32
first_clone=ocaml-4.02.3-$bits
second_clone=gs-4.02.3+ios-$bits

git clone -b 4.02.3 https://github.com/ocaml/ocaml ${first_clone}

cd ${first_clone}

sed -i "" "1s/4.02.3/4.02.3+ios/g" VERSION
./configure -prefix ${prefix}/release
make world.opt
make install

PATH=${prefix}/release/bin:${PATH}

cd ..

git clone -b gs-4.02.3+ios https://github.com/gerdstolpmann/ocaml ${second_clone}

cd ${second_clone}
sed -i "" "1s/4.02.3/4.02.3+ios/g" VERSION
sed -i "" '315s|`which ocamlrun`|$(BINDIR)/ocamlrun|g' Makefile
sed -i "" '12s|sdk=8.4|SDK=/Developer/SDKs/${platform}.sdk|' build.sh
sed -i "" '7s/.*/minver=7.0/g' build.sh
sed -i "" 's/-miphoneos-version-min=$sdk/-miphoneos-version-min=$minver/g' build.sh

./build.sh -prefix ${prefix} -target-bindir ${prefix}/bin
make install
