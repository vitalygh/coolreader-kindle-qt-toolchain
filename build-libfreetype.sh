#!/bin/sh
libname=libfreetype
libversion=2.4.4
libdir=freetype-$libversion
libfile=freetype-$libversion.tar.gz
liburl=https://download.savannah.gnu.org/releases/freetype/freetype-old/$libfile
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

cd $libname-build

#cd freetype-2.12.1
#cd freetype-$libversion
#make clean
#	CFLAGS="-I~/kindle/libz-bin/include $armflags $CFLAGS" \
#	LDFLAGS="-L~/kindle/libz-bin/lib -lz $LDFLAGS" \
	CC=$armcompiller-gcc \
	CFLAGS="$armflags $CFLAGS" \
	$buildpath/$libdir/configure \
	--host=arm-linux \
	--prefix=/$libspath/$libname-bin &&
make clean &&
make -j2 -l2 &&
make install &&
echo Success!


