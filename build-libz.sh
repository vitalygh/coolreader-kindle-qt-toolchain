#!/bin/sh
libname=libz
libversion=1.2.12
libdir=zlib-$libversion
libfile=zlib-$libversion.tar.xz
liburl=https://zlib.net/$libfile
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

#cd zlib-$libversion
#make clean
	#CFLAGS=-fPIC \
	#CXXFLAGS=-fPIC \
	#AR=$armcompiller-ar \
	#CHOST=arm \
	#LD=$armcompiller-ld \
	#RANLIB=$armcompiller-ranlib \
	#CFLAGS="-fPIC -DPIC" \
	#CC=$armcompiller-gcc \
	#--shared \
	CROSS_PREFIX=$armcompiller- \
	CFLAGS="$armflags $CFLAGS" \
	$buildpath/$libdir/configure \
	--prefix=$libspath/$libname-bin &&
make clean &&
make -j2 -l2 &&
make install &&
echo Success!



