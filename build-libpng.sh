#!/bin/sh
libname=libpng
libversion=1.5.30
libdir=$libname-$libversion
libfile=$libdir.tar.xz
liburl=https://download.sourceforge.net/libpng/$libfile
. ./build-config.sh

libbinpath=$libpngpath
[ -z "$libbinpath" ] && libbinpath=$libspath/$libname-bin
if [ -d $libbinpath/lib ]; then
	echo $libname already builded, skip
	exit
fi

[ -z "$libzpath" ] && libzpath=$libspath/libz-bin

mkdir -p $libspath
mkdir -p $buildpath
#cd $libspath/
rm -fr $libbinpath
mkdir -p $libbinpath
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
	CFLAGS="-I$libzpath/include $armflags $CFLAGS" \
	LDFLAGS="-L$libzpath/lib -lz $LDFLAGS" \
	./configure \
	--host=arm-linux \
	--prefix=$libbinpath &&
make -j$cores -l$cores &&
make install &&
echo Success!
