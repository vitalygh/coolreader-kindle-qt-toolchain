#!/bin/sh
scriptpath=$(dirname $(readlink -f "$0"))
libspath=$scriptpath/libs
buildpath=$scriptpath/libs/build
armflags="-march=armv7-a -mtune=cortex-a8"
#armabi=gnueabihf
armabi=gnueabi
armgccversion=4.9-2016.02
armgccdir=gcc-linaro-$armgccversion-x86_64_arm-linux-$armabi
armgccfile=$armgccdir.tar.xz
armgccurl=https://releases.linaro.org/components/toolchain/binaries/$armgccversion/arm-linux-$armabi/$armgccfile
armcompiller=$libspath/$armgccdir/bin/arm-linux-$armabi

if [ ! -d $libspath/$armgccdir ]; then
	mkdir -p $libspath
	mkdir -p $buildpath
	if [ ! -f $buildpath/$armgccfile ]; then
		wget $armgccurl -P $buildpath
	fi
	tar xvf $buildpath/$armgccfile -C $libspath
fi
