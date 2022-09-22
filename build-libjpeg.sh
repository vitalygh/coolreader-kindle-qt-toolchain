#!/bin/sh
libname=libjpeg
#libversion=8d1
libversion=8d
libdir=jpeg-$libversion
libfile=jpegsrc.v$libversion.tar.gz
liburl=https://www.ijg.org/files/$libfile
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
#cd ..
#cd ~/kindle/libjpeg-build
	#CFLAGS="-I~/kindle/zlib-bin/include" \
	#CPPFLAGS="-I~/kindle/zlib-bin/include" \
	#LDFLAGS="-L~/kindle/zlib-bin/lib" \
	CC=$armcompiller-gcc \
	CFLAGS="$armflags $CFLAGS" \
	./configure \
	--host=arm-linux \
	--prefix=$libspath/$libname-bin &&
make -j2 -l2 &&
make install &&
echo Success!



