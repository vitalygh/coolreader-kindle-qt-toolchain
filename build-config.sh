#!/bin/sh
scriptpath=$(dirname $(readlink -f "$0"))
cores=4
libspath=$scriptpath/libs
buildpath=$libspath/build
finalpath=$scriptpath/final
qtcreatordir=build-coolreader-Desktop-Release
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
qtversion=4.7.4
qtvera=$(echo $qtversion | cut -c1)
qtverb=$(echo $qtversion | cut -c3)
qtverc=$(echo $qtversion | cut -c5)

libzpath=$libspath/libz-bin
libexpatpath=$libspath/libexpat-bin
libexpatx64path=$libspath/libexpat-x64-bin
libjpegpath=$libspath/libjpeg-bin
libpngpath=$libspath/libpng-bin
libfreetypepath=$libspath/libfreetype-bin
libfontconfigpath=$libspath/libfontconfig-bin
libdbuspath=$libspath/libdbus-bin
libdbusx64path=$libspath/libdbus-x64-bin
libqtpath=$libspath/libqt-bin
crpath=$libspath/cr3-bin

if [ ! -d $libspath/$armgccdir/bin ]; then
	mkdir -p $libspath
	mkdir -p $buildpath
	if [ ! -f $buildpath/$armgccfile ]; then
		wget $armgccurl -P $buildpath
	fi
	tar xvf $buildpath/$armgccfile -C $libspath
fi
