#!/bin/sh
libname=libdbus
#libversion=0.93
libversion=1.13.22
libdir=dbus-$libversion
libfile=$libdir.tar.xz
liburl=https://dbus.freedesktop.org/releases/dbus/$libfile
libarch=$1

. ./build-config.sh

[ -z "$libarch" ] && libbinpath=$libdbuspath || libbinpath=$libdbusx64path
[ -z "$libbinpath" ] && libbinpath=$libspath/$libname$libarch-bin
if [ -d $libbinpath/lib ]; then
	echo $libname$libarch already builded, skip
	exit
fi

confcc=$armcompiller-gcc
confhost=--host=arm-linux-gnueabi
if [ ! -z "$libarch" ]; then
	confcc=$CC
	confhost=
	armflags=
fi

[ -z "$libarch" ] && libarchexpatpath=$libexpatpath || libarchexpatpath=$libexpatx64path
[ -z "$libarchexpatpath" ] && libexpatpath=$libspath/libexpat$libarch-bin

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

if [ -d $scriptpath/patch/$libdir ] && [ -d $buildpath/$libdir ]; then
	cp -R $scriptpath/patch/$libdir/* $buildpath/$libdir
fi

cd $buildpath/$libdir
make distclean

#cd dbus-1.0.2
#cd ~/kindle/libdbus-build
	#CFLAGS="-I~/kindle/libexpat-bin/include" \
	#CPPFLAGS="-I~/kindle/libexpat-bin/include" \
	#LDFLAGS="-L~/kindle/libexpat-bin/lib" \
	#EXPAT_CFLAGS="-I~/kindle/libexpat-bin/include" \
	#EXPAT_LIBS="-L~/kindle/libexpat-bin/lib" \
	#--host=arm-linux-gnueabihf \	
#CC=$armcompiller-gcc \
#CROSS_PREFIX=$armcompiller- \
#--exec-prefix=$armcompiller- \	

#	LIBS=-lexpat \
#	CPPFLAGS=-I~/kindle/libexpat-bin/include \
#	LDFLAGS=-L~/kindle/libexpat-bin/lib \

#	EXPAT_CFLAGS=-I~/kindle/libexpat-bin/include \
#	EXPAT_LIBS=-L~/kindle/libexpat-bin/lib \

#	CCXX=$armcompiller-g++ \
#	CPPFLAGS=-I~/kindle/libexpat-bin/include \

	ac_cv_func_posix_getpwnam_r=yes \
	ac_cv_have_abstract_sockets=yes \
	./configure \
	CC=$confcc \
	EXPAT_CFLAGS=-I$libarchexpatpath/include \
	EXPAT_LIBS=-L$libarchexpatpath/lib \
	CFLAGS="-I$libarchexpatpath/include $armflags $CFLAGS" \
	LDFLAGS=-L$libarchexpatpath/lib \
	LIBS=-lexpat \
	--disable-systemd \
	--without-x \
	--disable-modular-tests \
	$confhost \
	--prefix=$libbinpath &&
make -j$cores -l$cores &&
make install &&
echo Success!
