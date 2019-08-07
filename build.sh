#!/bin/bash

set -Eex
set -o pipefail

srcurl=https://github.com/openjdk/jdk12u
tag=$1

if [[ -z $tag ]]; then exit 2; fi

if ! test -d build; then
    rm -rf .build
    git clone $srcurl .build
    mv -v .build build
fi
cd build
git checkout master
git reset --hard
git pull
git checkout $tag
git reset --hard
commit=`git rev-parse HEAD`
export PATH=${PATH//:\/usr\/lib\/ccache/}

sed -i ./src/hotspot/share/gc/shared/gcConfig.cpp -e 's:FLAG_SET_ERGO_IF_DEFAULT(bool, UseG1GC, true);:FLAG_SET_ERGO_IF_DEFAULT(bool, UseParallelGC, true);:g'
cnt=$(git diff | wc -l)
if (( cnt == 0 )); then exit 3; fi

bash ./configure --disable-warnings-as-errors --with-version-pre=$commit --with-version-opt="$tag.parallelgcdefault"
make clean
time nice make bundles
./build/linux*/jdk/bin/java -verbose:gc --version | head -n1 | grep -i parallel
ls -ld build/linux*/bundles/*
echo Done.

