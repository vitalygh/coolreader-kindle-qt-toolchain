#!/bin/sh
libname=libfontconfig
libversion=2.11.1
libdir=fontconfig-$libversion
libfile=$libdir.tar.bz2
liburl=https://www.freedesktop.org/software/fontconfig/release/$libfile
. ./build-config.sh

libbinpath=$libfontconfigpath
[ -z "$libbinpath" ] && libbinpath=$libspath/$libname-bin
if [ -d $libbinpath/lib ]; then
	echo $libname already builded, skip
	exit
fi

[ -z "$libfreetypepath" ] && libfreetypepath=$libspath/libfreetype-bin
[ -z "$libzpath" ] && libzpath=$libspath/libz-bin
[ -z "$libexpatpath" ] && libexpatpath=$libspath/libexpat-bin

mkdir -p $libspath
mkdir -p $buildpath
#cd $libspath/
rm -fr $libfontconfigpath
mkdir -p $libfontconfigpath
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
	FREETYPE_CFLAGS=-I$libfreetypepath/include \
	FREETYPE_LIBS=-L$libfreetypepath/lib \
	CFLAGS="-I$libexpatpath/include -I$libfreetypepath/include/freetype2 -I$libzpath/include $armflags $CFLAGS" \
	LDFLAGS="-L$libexpatpath/lib -lexpat -L$libfreetypepath/lib -lfreetype -L$libzpath/lib -lz" \
	--host=arm-linux \
	--prefix=$libbinpath &&
make -j$cores -l$cores &&
make install &&
echo Success!


