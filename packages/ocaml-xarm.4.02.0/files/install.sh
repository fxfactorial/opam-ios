#!/bin/sh -e

PREFIX="$1"

rm -rf "${PREFIX}"/bin "${PREFIX}"/lib "${PREFIX}"/man

sed -i -e s/OCAMLDIR/"${PREFIX}"/g ocamloptrev
mv ocamloptrev "${PREFIX}"/bin
mv bin "${PREFIX}"
mv lib "${PREFIX}"
mv man "${PREFIX}"
