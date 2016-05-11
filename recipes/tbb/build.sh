#!/bin/sh

# clang: error: invalid deployment target for -stdlib=libc++
export MACOSX_DEPLOYMENT_TARGET=10.7

make

install -d ${PREFIX}/lib
# filter libtbb.dylib ( or .so ), libtbbmalloc.dylib ( or .so )
cp `find . -name "*lib*" | grep tbb | grep release` ${PREFIX}/lib

install -d ${PREFIX}/include
# copy the include files
cp -r ./include/tbb ${PREFIX}/include

# simple test instead of "make test" to avoid timeout
c++ ${RECIPE_DIR}/tbb_example.c -I${PREFIX}/include -L${PREFIX}/lib -ltbb -o tbb_example

if test `uname` = "Darwin"
then
  install_name_tool -change @rpath/libtbb.dylib ${PREFIX}/lib/libtbb.dylib tbb_example
fi

./tbb_example
