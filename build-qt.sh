#!/bin/sh
libname=qt
#qtversion=4.7.4
libversion=4.8.7
libdir=$libname-everywhere-opensource-src-$libversion
libfile=$libdir.tar.gz
liburl=https://download.qt.io/archive/qt/4.8/4.8.7/$libfile
. ./build-config.sh

if [ -d $libspath/$libname-bin/lib ]; then
	echo $libname already builded, skip
	exit
fi

mkdir -p $libspath
mkdir -p $buildpath
cd $libspath/
rm -fr $libname-bin
mkdir -p $libname-bin
cd $buildpath
rm -fr $libname-build
mkdir -p $libname-build

if [ ! -d $libdir ]; then
	if [ ! -f $libfile ]; then
		wget $liburl
	fi
	tar xvf $libfile
fi

if [ -d $scriptpath/patch/$libname-$libversion ] && [ -d $buildpath/$libdir ]; then
	cp -R $scriptpath/patch/$libname-$libversion/* $buildpath/$libdir
	sed -i "s+armcompiller+$armcompiller+" $buildpath/$libdir/mkspecs/qws/linux-arm-kindle-g++/qmake.conf
fi

cd $libname-build

$buildpath/$libdir/configure -v \
	-embedded arm \
	-xplatform qws/linux-arm-kindle-g++ \
	-little-endian \
	-opensource \
	-confirm-license \
	-prefix $libspath/qt-bin \
	-no-webkit \
	-no-cups \
	-nomake examples \
	-nomake demos \
	-dbus \
	-dbus-linked \
	-I$libspath/libexpat-bin/include \
	-L$libspath/libexpat-bin/lib \
	-lexpat \
	-I$libspath/libdbus-bin/include \
	-I$libspath/libdbus-bin/include/dbus-1.0 \
	-I$libspath/libdbus-bin/include/dbus-1.0/dbus \
	-I$libspath/libdbus-bin/lib/dbus-1.0/include \
	-L$libspath/libdbus-bin/lib \
	-L$libspath/libdbus-x64-bin/lib \
	-ldbus-1 &&
# -nomake tools
# -no-style-windows -no-style-windowsxp -no-style-windowsvista -fast -no-iconv -no-phonon -no-qt3support -no-3dnow -no-sse -no-sse2 -no-openssl -no-mmx -no-stl -no-nis -no-opengl
#	-I~/kindle/libdbus-x64-bin/include \
#	-I~/kindle/libdbus-x64-bin/include/dbus-1.0 \
#	-I~/kindle/libdbus-x64-bin/include/dbus-1.0/dbus \
#	-I~/kindle/libdbus-x64-bin/lib/dbus-1.0/include \
#	-L~/kindle/libdbus-x64-bin/lib \
make clean &&
make -j2 -l2 &&
make install &&
echo Success!



