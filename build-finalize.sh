#!/bin/sh
finaldir=/final
#finaldir=
. ./build-config.sh

sp=$scriptpath
if [ -d $finalpath/qtKindle/lib ]; then
	echo $finalpath already builded, skip
	exit
fi

#rm -fr $finalpath/qtKindle/lib
mkdir -p $finalpath
mkdir -p $finalpath/cr3
mkdir -p $finalpath/cr3/lib
mkdir -p $finalpath/cr3/data
mkdir -p $finalpath/qtKindle
mkdir -p $finalpath/qtKindle/plugins
mkdir -p $finalpath/qtKindle/plugins/bearer
mkdir -p $finalpath/qtKindle/plugins/gfxdrivers
mkdir -p $finalpath/qtKindle/plugins/imageformats
mkdir -p $finalpath/qtKindle/plugins/kbddrivers
mkdir -p $finalpath/qtKindle/plugins/mousedrivers
mkdir -p $finalpath/qtKindle/lib
mkdir -p $finalpath/qtKindle/lib/pkgconfig

if [ -f $sp/$qtcreatordir/cr3-kindle/src/cr3 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/cr3 $finalpath/cr3/cr3
else
	cp $crpath/cr3 $finalpath/cr3/cr3
fi

if [ -f $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 $finalpath/cr3/lib/libdevice.so.1
else
	cp $crpath/lib/libdevice.so.1 $finalpath/cr3/lib/libdevice.so.1
fi

if [ -d $sp/$qtcreatordir/cr3-kindle/src/data ]; then
	cp -r $sp/$qtcreatordir/cr3-kindle/src/data/* $finalpath/cr3/data
else
	cp -r $crpath/data/* $finalpath/cr3/data
fi

cp $libexpatpath/lib/libexpat.so.1.8.8 $finalpath/cr3/lib/libexpat.so.1
cp $libfontconfigpath/lib/libfontconfig.so.1.8.0 $finalpath/cr3/lib/libfontconfig.so.1
cp $libjpegpath/lib/libjpeg.so.8.4.0 $finalpath/cr3/lib/libjpeg.so.8
cp $libpngpath/lib/libpng15.so.15.30.0 $finalpath/cr3/lib/libpng15.so.15
cp $libzpath/lib/libz.so.1.2.12 $finalpath/cr3/lib/libz.so.1

if [ -f $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so ]; then
	cp $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so $finalpath/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
else
	cp $libqtpath/plugins/kbddrivers/libKindleKeyboard.so $finalpath/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so $finalpath/qtKindle/plugins/gfxdrivers/libQKindleFb.so
else
	cp $libqtpath/plugins/gfxdrivers/libQKindleFb.so $finalpath/qtKindle/plugins/gfxdrivers/libQKindleFb.so
fi
#if [ -f $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so ]; then
#	cp $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so $finalpath/qtKindle/plugins/mousedrivers/libKindleTS.so
#else
#	cp $libqtpath/plugins/mousedrivers/libKindleTS.so $finalpath/qtKindle/plugins/mousedrivers/libKindleTS.so
#fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/KindleFiveWay/libKindleFiveWay.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/KindleFiveWay/libKindleFiveWay.so $finalpath/qtKindle/plugins/mousedrivers/libKindleFiveWay.so
else
	cp $libqtpath/plugins/mousedrivers/libKindleFiveWay.so $finalpath/qtKindle/plugins/mousedrivers/libKindleFiveWay.so
fi

cp $libfreetypepath/lib/libfreetype.so.6.6.2 $finalpath/qtKindle/lib/libfreetype.so.6
cp $libqtpath/lib/libQtCore.so.$qtversion $finalpath/qtKindle/lib/libQtCore.so.4
cp $libqtpath/lib/libQtDBus.so.$qtversion $finalpath/qtKindle/lib/libQtDBus.so.4
cp $libqtpath/lib/libQtGui.so.$qtversion $finalpath/qtKindle/lib/libQtGui.so.4
cp $libqtpath/lib/libQtNetwork.so.$qtversion $finalpath/qtKindle/lib/libQtNetwork.so.4
cp $libqtpath/lib/libQtXml.so.$qtversion $finalpath/qtKindle/lib/libQtXml.so.4

cp $libqtpath/plugins/bearer/libqconnmanbearer.so $finalpath/qtKindle/plugins/bearer/libqconnmanbearer.so
cp $libqtpath/plugins/bearer/libqgenericbearer.so $finalpath/qtKindle/plugins/bearer/libqgenericbearer.so
cp $libqtpath/plugins/bearer/libqnmbearer.so $finalpath/qtKindle/plugins/bearer/libqnmbearer.so

cp $libqtpath/plugins/imageformats/libqgif.so $finalpath/qtKindle/plugins/imageformats/libqgif.so
cp $libqtpath/plugins/imageformats/libqico.so $finalpath/qtKindle/plugins/imageformats/libqico.so
cp $libqtpath/plugins/imageformats/libqjpeg.so $finalpath/qtKindle/plugins/imageformats/libqjpeg.so
cp $libqtpath/plugins/imageformats/libqmng.so $finalpath/qtKindle/plugins/imageformats/libqmng.so
cp $libqtpath/plugins/imageformats/libqtiff.so $finalpath/qtKindle/plugins/imageformats/libqtiff.so

cp $libfreetypepath/lib/pkgconfig/freetype2.pc $finalpath/qtKindle/lib/pkgconfig/freetype2.pc
cp $libqtpath/lib/pkgconfig/QtCore.pc $finalpath/qtKindle/lib/pkgconfig/QtCore.pc
cp $libqtpath/lib/pkgconfig/QtDBus.pc $finalpath/qtKindle/lib/pkgconfig/QtDBus.pc
cp $libqtpath/lib/pkgconfig/QtGui.pc $finalpath/qtKindle/lib/pkgconfig/QtGui.pc
cp $libqtpath/lib/pkgconfig/QtNetwork.pc $finalpath/qtKindle/lib/pkgconfig/QtNetwork.pc
cp $libqtpath/lib/pkgconfig/QtSql.pc $finalpath/qtKindle/lib/pkgconfig/QtSql.pc
cp $libqtpath/lib/pkgconfig/QtTest.pc $finalpath/qtKindle/lib/pkgconfig/QtTest.pc
cp $libqtpath/lib/pkgconfig/QtXml.pc $finalpath/qtKindle/lib/pkgconfig/QtXml.pc
