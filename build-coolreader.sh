#!/bin/sh
libdir=coolreader-kindle-qt
liburl=https://github.com/CrazyCoder/$libdir
librevision=5a85ba1f0b30f67b4a3ea029d1f50a5709c6c1f0
. ./build-config.sh

if [ -f $scriptpath/final/cr3/cr3 ]; then
	echo $libdir already builded, skip
	exit
fi

if [ ! -d $scriptpath/$libdir ]; then
	git clone --recurse-submodules $liburl $scriptpath/$libdir
	#git -C $scriptpath/$libdir clean -fd
	#git -C $scriptpath/$libdir checkout .
	#git -C $scriptpath/$libdir pull --ff-only
	git -C $scriptpath/$libdir checkout $librevision	
fi

cwd=$(pwd)
cd $scriptpath/$libdir
make distclean

if [ -d $scriptpath/patch/$libdir ] && [ -d $scriptpath/$libdir ]; then
	cp -R $scriptpath/patch/$libdir/* $scriptpath/$libdir
fi

$libspath/qt-bin/bin/qmake coolreader.pro &&
make -j2 -l2 &&
make install &&
echo Success!

if [ -d $scriptpath/patch/$libdir ] && [ -d $scriptpath/$libdir ]; then
	cp -R $scriptpath/patch/$libdir/* $scriptpath/$libdir
fi

$libspath/qt-bin/bin/qmake coolreader.pro &&
make -j2 -l2 &&
make install &&
echo Success!

cd $cwd
