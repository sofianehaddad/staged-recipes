rem  @echo off

mkdir build
cd build

set CMAKE_CONFIG="Release"

if not defined CMAKE_GENERATOR EXIT 1

cmake -LAH -G%CMAKE_GENERATOR%                               ^
    -DPYTHON_EXECUTABLE="%PYTHON%"                           ^
    -DPYTHON_INCLUDE_PATH="%PREFIX%\include"                 ^
    -DPYTHON_LIBRARY="%PREFIX%\libs\python%PY_VER:.=%.lib"   ^
    -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%" ..

cmake --build . --config %CMAKE_CONFIG% --target ALL_BUILD
cmake --build . --config %CMAKE_CONFIG% --target INSTALL

if errorlevel 1 exit 1

