#!/bin/sh
scriptpath=$(dirname $(readlink -f "$0"))
cores=2
libspath=$scriptpath/libs
buildpath=$scriptpath/libs/build
qmakerpath=/mnt/us/qtKindle/lib
armflags="-march=armv7-a -mtune=cortex-a8 -marm -mfpu=neon"
#qmakeflags="$armflags -Wl,-rpath,$qmakerpath, -Wl,-rpath-link,$qmakerpath"
qmakeflags=$armflags
#armabi=gnueabihf
armabi=gnueabi
armgccversion=4.9-2016.02
armgccurldir=$armgccversion
#armgccversion=4.9.4-2017.01
#armgccurldir=4.9-2017.01
armgccdir=gcc-linaro-$armgccversion-x86_64_arm-linux-$armabi
armgccfile=$armgccdir.tar.xz
armgccurl=https://releases.linaro.org/components/toolchain/binaries/$armgccurldir/arm-linux-$armabi/$armgccfile
armcompiller=$libspath/$armgccdir/bin/arm-linux-$armabi
qmakecompiller=$armcompiller

if [ ! -d $libspath/$armgccdir/bin ]; then
	mkdir -p $libspath
	mkdir -p $buildpath
	if [ ! -f $buildpath/$armgccfile ]; then
		wget $armgccurl -P $buildpath
	fi
	tar xvf $buildpath/$armgccfile -C $libspath
fi
