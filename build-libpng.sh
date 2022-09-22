#!/bin/sh
libname=libpng
libversion=1.5.30
libdir=$libname-$libversion
libfile=$libdir.tar.xz
liburl=https://download.sourceforge.net/libpng/$libfile
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

	CC=$armcompiller-gcc \
	CFLAGS="-I$libspath/libz-bin/include $armflags $CFLAGS" \
	LDFLAGS="-L$libspath/libz-bin/lib -lz $LDFLAGS" \
	./configure \
	--host=arm-linux \
	--prefix=$libspath/$libname-bin &&
make -j2 -l2 &&
make install &&
echo Success!
