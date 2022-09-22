#!/bin/sh
libname=libexpat
#libversion=1.95.7
libversion=2.4.8
libdir=expat-$libversion
libfile=expat-$libversion.tar.xz
liburl=https://github.com/libexpat/libexpat/releases/download/R_$(echo $libversion | tr . _)/$libfile
libarch=$1
. ./build-config.sh

[ -z "$libarch" ] && libbinpath=$libexpatpath || libbinpath=$libexpatx64path
[ -z "$libbinpath" ] && libbinpath=$libspath/$libname$libarch-bin
if [ -d $libbinpath/lib ]; then
	echo $libname$libarch already builded, skip
	exit
fi

confcc=$armcompiller-gcc
confhost=--host=arm-linux
if [ ! -z "$libarch" ]; then
	confcc=$CCzzz
	confhost=
	armflags=
fi

mkdir -p $libspath
mkdir -p $buildpath
rm -fr $libbinpath
mkdir -p $libbinpath
cd $buildpath
rm -fr $libname$libarch-build
mkdir -p $libname$libarch-build


if [ ! -d $libdir ]; then
	if [ ! -f $libfile ]; then
		wget $liburl
	fi
	tar xvf $libfile
fi

cd $libname$libarch-build

	#CFLAGS="-I~/kindle/zlib-bin/include" \
	#CPPFLAGS="-I~/kindle/zlib-bin/include" \
	#LDFLAGS="-L~/kindle/zlib-bin/lib" \
	CC=$confcc \
	CFLAGS="$armflags $CFLAGS" \
	$buildpath/$libdir/configure \
	$confhost \
	--prefix=$libbinpath &&
make clean &&
make -j$cores -l$cores &&
make install &&
echo Success!
