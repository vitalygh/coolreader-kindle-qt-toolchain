#!/bin/sh
libname=libjpeg
#libversion=8d1
libversion=8d
libdir=jpeg-$libversion
libfile=jpegsrc.v$libversion.tar.gz
liburl=https://www.ijg.org/files/$libfile
. ./build-config.sh

libbinpath=$libjpegpath
[ -z "$libbinpath" ] && libbinpath=$libspath/$libname-bin
if [ -d $libbinpath/lib ]; then
	echo $libname already builded, skip
	exit
fi

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
#cd ..
#cd ~/kindle/libjpeg-build
	#CFLAGS="-I~/kindle/zlib-bin/include" \
	#CPPFLAGS="-I~/kindle/zlib-bin/include" \
	#LDFLAGS="-L~/kindle/zlib-bin/lib" \
	CC=$armcompiller-gcc \
	CFLAGS="$armflags $CFLAGS" \
	./configure \
	--host=arm-linux \
	--prefix=$libbinpath &&
make -j$cores -l$cores &&
make install &&
echo Success!



