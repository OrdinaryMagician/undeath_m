#!/bin/sh
WORKDIR=$(dirname $(dirname $(readlink -f $0)))
pushd "$WORKDIR"
7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=off -x@tools/excl.lst -up0q0r2x2y2z1w2 ../undeath${1}_m.ipk7 .
popd
