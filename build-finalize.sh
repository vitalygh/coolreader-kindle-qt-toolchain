#!/bin/sh
qtcreatordir=build-coolreader-Desktop-Release
finaldir=/final
#finaldir=
qtsubversion=7.4
#qtsubversion=8.7
. ./build-config.sh

sp=$scriptpath
fd=$finaldir
if [ -d $sp$fd/qtKindle/lib ]; then
	echo $sp$fd already builded, skip
	exit
fi

#rm -fr $sp$finaldir/qtKindle/lib
mkdir -p $sp$fd
mkdir -p $sp$fd/cr3
mkdir -p $sp$fd/cr3/lib
mkdir -p $sp$fd/cr3/data
mkdir -p $sp$fd/qtKindle
mkdir -p $sp$fd/qtKindle/plugins
mkdir -p $sp$fd/qtKindle/plugins/bearer
mkdir -p $sp$fd/qtKindle/plugins/gfxdrivers
mkdir -p $sp$fd/qtKindle/plugins/imageformats
mkdir -p $sp$fd/qtKindle/plugins/kbddrivers
mkdir -p $sp$fd/qtKindle/plugins/mousedrivers
mkdir -p $sp$fd/qtKindle/lib
mkdir -p $sp$fd/qtKindle/lib/pkgconfig

if [ -f $sp/$qtcreatordir/cr3-kindle/src/cr3 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/cr3 $sp$fd/cr3/cr3
else
	cp $crpath/cr3 $sp$fd/cr3/cr3
fi

if [ -f $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 $sp$fd/cr3/lib/libdevice.so.1
else
	cp $crpath/lib/libdevice.so.1 $sp$fd/cr3/lib/libdevice.so.1
fi

if [ -d $sp/$qtcreatordir/cr3-kindle/src/data ]; then
	cp -r $sp/$qtcreatordir/cr3-kindle/src/data/* $sp$fd/cr3/data
else
	cp -r $crpath/data/* $sp$fd/cr3/data
fi

cp $libexpatpath/lib/libexpat.so.1.8.8 $sp$fd/cr3/lib/libexpat.so.1
cp $libfontconfigpath/lib/libfontconfig.so.1.8.0 $sp$fd/cr3/lib/libfontconfig.so.1
cp $libjpegpath/lib/libjpeg.so.8.4.0 $sp$fd/cr3/lib/libjpeg.so.8
cp $libpngpath/lib/libpng15.so.15.30.0 $sp$fd/cr3/lib/libpng15.so.15
cp $libzpath/lib/libz.so.1.2.12 $sp$fd/cr3/lib/libz.so.1

if [ -f $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so ]; then
	cp $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so $sp$fd/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
else
	cp $libqtpath/plugins/kbddrivers/libKindleKeyboard.so $sp$fd/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so $sp$fd/qtKindle/plugins/gfxdrivers/libQKindleFb.so
else
	cp $libqtpath/plugins/gfxdrivers/libQKindleFb.so $sp$fd/qtKindle/plugins/gfxdrivers/libQKindleFb.so
fi
#if [ -f $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so ]; then
#	cp $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so $sp$fd/qtKindle/plugins/mousedrivers/libKindleTS.so
#else
#	cp $libqtpath/plugins/mousedrivers/libKindleTS.so $sp$fd/qtKindle/plugins/mousedrivers/libKindleTS.so
#fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/KindleFiveWay/libKindleFiveWay.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/KindleFiveWay/libKindleFiveWay.so $sp$fd/qtKindle/plugins/mousedrivers/libKindleFiveWay.so
else
	cp $libqtpath/plugins/mousedrivers/libKindleFiveWay.so $sp$fd/qtKindle/plugins/mousedrivers/libKindleFiveWay.so
fi

cp $libfreetypepath/lib/libfreetype.so.6.6.2 $sp$fd/qtKindle/lib/libfreetype.so.6
cp $libqtpath/lib/libQtCore.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtCore.so.4
cp $libqtpath/lib/libQtDBus.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtDBus.so.4
cp $libqtpath/lib/libQtGui.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtGui.so.4
cp $libqtpath/lib/libQtNetwork.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtNetwork.so.4
cp $libqtpath/lib/libQtXml.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtXml.so.4

cp $libqtpath/plugins/bearer/libqconnmanbearer.so $sp$fd/qtKindle/plugins/bearer/libqconnmanbearer.so
cp $libqtpath/plugins/bearer/libqgenericbearer.so $sp$fd/qtKindle/plugins/bearer/libqgenericbearer.so
cp $libqtpath/plugins/bearer/libqnmbearer.so $sp$fd/qtKindle/plugins/bearer/libqnmbearer.so

cp $libqtpath/plugins/imageformats/libqgif.so $sp$fd/qtKindle/plugins/imageformats/libqgif.so
cp $libqtpath/plugins/imageformats/libqico.so $sp$fd/qtKindle/plugins/imageformats/libqico.so
cp $libqtpath/plugins/imageformats/libqjpeg.so $sp$fd/qtKindle/plugins/imageformats/libqjpeg.so
cp $libqtpath/plugins/imageformats/libqmng.so $sp$fd/qtKindle/plugins/imageformats/libqmng.so
cp $libqtpath/plugins/imageformats/libqtiff.so $sp$fd/qtKindle/plugins/imageformats/libqtiff.so

cp $libfreetypepath/lib/pkgconfig/freetype2.pc $sp$fd/qtKindle/lib/pkgconfig/freetype2.pc
cp $libqtpath/lib/pkgconfig/QtCore.pc $sp$fd/qtKindle/lib/pkgconfig/QtCore.pc
cp $libqtpath/lib/pkgconfig/QtDBus.pc $sp$fd/qtKindle/lib/pkgconfig/QtDBus.pc
cp $libqtpath/lib/pkgconfig/QtGui.pc $sp$fd/qtKindle/lib/pkgconfig/QtGui.pc
cp $libqtpath/lib/pkgconfig/QtNetwork.pc $sp$fd/qtKindle/lib/pkgconfig/QtNetwork.pc
cp $libqtpath/lib/pkgconfig/QtSql.pc $sp$fd/qtKindle/lib/pkgconfig/QtSql.pc
cp $libqtpath/lib/pkgconfig/QtTest.pc $sp$fd/qtKindle/lib/pkgconfig/QtTest.pc
cp $libqtpath/lib/pkgconfig/QtXml.pc $sp$fd/qtKindle/lib/pkgconfig/QtXml.pc
