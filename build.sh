#!/bin/sh
./build-libz.sh &&
./build-libexpat.sh &&
./build-libexpat-x64.sh &&
./build-libjpeg.sh &&
./build-libpng.sh &&
./build-libfreetype.sh &&
./build-libfontconfig.sh &&
./build-libdbus.sh &&
./build-libdbus-x64.sh &&
./build-qt.sh &&
./build-coolreader.sh &&
./build-finalize.sh &&
echo Total success!

