#!/bin/sh
libname=libfontconfig
libversion=2.11.1
libdir=fontconfig-$libversion
libfile=$libdir.tar.bz2
liburl=https://www.freedesktop.org/software/fontconfig/release/$libfile
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

if [ ! -d $libdir ]; then
	if [ ! -f $libfile ]; then
		wget $liburl
	fi
	tar xvf $libfile
fi

cd $buildpath/$libdir
make distclean

#cd ~/kindle/libfontconfig-build
	#FREETYPE_CFLAGS=-I~/kindle/libfreetype-bin/include \
	#FREETYPE_LIBS=-L~/kindle/libfreetype-bin/lib \
	#CC=$armcompiller-gcc \
	#	--host=arm-linux \
	#CFLAGS="-I~/kindle/libuuid-bin/include -I~/kindle/libfreetype-bin/include/freetype2 -I~/kindle/libexpat-bin/include" \
	#LDFLAGS="-L~/kindle/libuuid-bin/lib -L~/kindle/libexpat-bin/lib -L~/kindle/libfreetype-bin/lib -lfreetype -luuid -lexpat" \
	#CFLAGS="-I~/kindle/libuuid-bin/include -I~/kindle/libfreetype-bin/include/freetype2 -I~/kindle/libexpat-bin/include" \
	#LDFLAGS="-L~/kindle/libuuid-bin/lib -L~/kindle/libexpat-bin/lib -L~/kindle/libfreetype-bin/lib -lfreetype -luuid -lexpat" \
	#FREETYPE_CFLAGS=-I~/kindle/libfreetype-bin/include \
	#FREETYPE_LIBS=-L~/kindle/libfreetype-bin/lib \
	#CROSS_PREFIX=$armcompiller- \
	CC=$armcompiller-gcc \
	./configure \
	FREETYPE_CFLAGS=-I$libspath/libfreetype-bin/include \
	FREETYPE_LIBS=-L$libspath/libfreetype-bin/lib \
	CFLAGS="-I$libspath/libexpat-bin/include -I$libspath/libfreetype-bin/include/freetype2 -I$libspath/libzlib-bin/include $armflags $CFLAGS" \
	LDFLAGS="-L$libspath/libexpat-bin/lib -lexpat -L$libspath/libfreetype-bin/lib -lfreetype -L$libspath/libz-bin/lib -lz" \
	--host=arm-linux \
	--prefix=$libspath/$libname-bin &&
make -j2 -l2 &&
make install &&
echo Success!


