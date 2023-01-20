#!/bin/sh
libname=libz
libversion=1.2.13
libdir=zlib-$libversion
libfile=zlib-$libversion.tar.gz
liburl=https://zlib.net/$libfile
. ./build-config.sh

libbinpath=$libzpath
[ -z "$libbinpath" ] && libbinpath=$libspath/$libname-bin
if [ -d $libbinpath/lib ]; then
	echo $libname already builded, skip
	exit
fi

mkdir -p $libspath
mkdir -p $buildpath
rm -fr $libbinpath
mkdir -p $libbinpath
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
	--prefix=$libbinpath &&
make clean &&
make -j$cores -l$cores &&
make install &&
echo Success!



