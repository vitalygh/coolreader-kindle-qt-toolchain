#!/bin/sh
libname=libexpat
#libversion=1.95.7
libversion=2.4.8
libdir=expat-$libversion
libfile=expat-$libversion.tar.xz
liburl=https://github.com/libexpat/libexpat/releases/download/R_$(echo $libversion | tr . _)/$libfile
libarch=
. ./build-config.sh

if [ -d $libspath/$libname$libarch-bin/lib ]; then
	echo $libname$libarch already builded, skip
	exit
fi

mkdir -p $libspath
mkdir -p $buildpath
cd $libspath/
rm -fr $libname$libarch-bin
mkdir -p $libname$libarch-bin
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
	CC=$armcompiller-gcc \
	CFLAGS="$armflags $CFLAGS" \
	$buildpath/$libdir/configure \
	--host=arm-linux \
	--prefix=$libspath/$libname$libarch-bin &&
make clean &&
make -j$cores -l$cores &&
make install &&
echo Success!
