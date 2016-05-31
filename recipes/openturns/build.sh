#!/bin/sh

if test `uname` = "Darwin"
then
  SO_EXT='.dylib'
else
  SO_EXT='.so'
fi

mkdir -p build && cd build

cmake \
  -DCMAKE_FIND_ROOT_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DLAPACKE_FOUND=TRUE -DOPENTURNS_LIBRARIES="$PREFIX/lib/libopenblas${SO_EXT}" \
  -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib" \
  -DPYTHON_EXECUTABLE="$PYTHON"                                \
  -DPYTHON_INCLUDE_PATH="$PREFIX/include/python${PY_VER}"      \
  -DPYTHON_LIBRARY="$PREFIX/lib/libpython${PY_VER}${SO_EXT}"  \
  ..

make install
DYLD_FALLBACK_LIBRARY_PATH=${PREFIX}/lib ctest -R pyinstallcheck --output-on-failure ${MAKEFLAGS} 
