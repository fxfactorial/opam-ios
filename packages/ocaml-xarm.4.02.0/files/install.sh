#!/bin/sh -e

PREFIX="$1"

rm -rf "${PREFIX}"/bin "${PREFIX}"/lib "${PREFIX}"/man

sed -i bak -e 's|OCAMLDIR|'${PREFIX}'|g' ocamloptrev

mv bin "${PREFIX}"

cp ocamloptrev "${PREFIX}"/bin

mv lib "${PREFIX}"
mv man "${PREFIX}"
