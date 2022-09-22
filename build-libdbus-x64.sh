#!/bin/sh
libname=libdbus
#libversion=0.93
libversion=1.13.22
libdir=dbus-$libversion
libfile=$libdir.tar.xz
liburl=https://dbus.freedesktop.org/releases/dbus/$libfile
libarch=-x64
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

if [ ! -d $libdir ]; then
	if [ ! -f $libfile ]; then
		wget $liburl
	fi
	tar xvf $libfile
fi

if [ -d $scriptpath/patch/$libdir ] && [ -d $buildpath/$libdir ]; then
	cp -R $scriptpath/patch/$libdir/* $buildpath/$libdir
fi

cd $buildpath/$libdir
make distclean
#cd dbus-1.0.2
#cd ~/kindle/libdbus-x64-build
	#CFLAGS="-I~/kindle/libexpat-x64-bin/include" \
	#CPPFLAGS="-I~/kindle/libexpat-x64-bin/include" \
	#LDFLAGS="-L~/kindle/libexpat-x64-bin/lib" \
	#EXPAT_CFLAGS="-I~/kindle/libexpat-x64-bin/include" \
	#EXPAT_LIBS="-L~/kindle/libexpat-x64-bin/lib" \
	#--host=arm-linux-gnueabihf \	
#CC=~/kindle/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc \
#CROSS_PREFIX=~/kindle/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf- \
#--exec-prefix=~/kindle/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf- \	

#	LIBS=-lexpat \
#	CPPFLAGS=-I~/kindle/libexpat-x64-bin/include \
#	LDFLAGS=-L~/kindle/libexpat-x64-bin/lib \

#	EXPAT_CFLAGS=-I~/kindle/libexpat-bin/include \
#	EXPAT_LIBS=-L~/kindle/libexpat-bin/lib \

#	CCXX=~/kindle/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ \
#	CPPFLAGS=-I~/kindle/libexpat-bin/include \

#	CC=~/kindle/gcc-linaro-4.9-2016.02-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-gcc \
#	--host=arm-linux-gnueabi &&

	ac_cv_func_posix_getpwnam_r=yes \
	ac_cv_have_abstract_sockets=yes \
	./configure	\
	CFLAGS="-I$libspath/libexpat$libarch-bin/include $CFLAGS" \
	LDFLAGS=-L$libspath/libexpat$libarch-bin/lib \
	LIBS=-lexpat \
	--prefix=$libspath/$libname$libarch-bin &&
make -j2 -l2 &&
make install &&
echo Success!
