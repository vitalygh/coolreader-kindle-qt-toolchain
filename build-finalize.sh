#!/bin/sh
qtcreatordir=build-coolreader-Desktop-Release
finaldir=/final
#finaldir=
qtsubversion=7.4
#qtsubversion=8.7
. ./build-config.sh

sp=$scriptpath
fd=$finaldir
#qtdir=$libspath/qt-bin/lib
qtdir=$scriptpath/qtKindle
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
mkdir -p $sp$fd/qtKindle/plugins/kbddrivers
mkdir -p $sp$fd/qtKindle/plugins/gfxdrivers
mkdir -p $sp$fd/qtKindle/plugins/mousedrivers
mkdir -p $sp$fd/qtKindle/lib
mkdir -p $sp$fd/qtKindle/lib/pkgconfig

if [ -f $sp/$qtcreatordir/cr3-kindle/src/cr3 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/cr3 $sp$fd/cr3/cr3
else
	cp $sp/cr3/cr3 $sp$fd/cr3/cr3
fi

if [ -f $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 $sp$fd/cr3/lib/libdevice.so.1
else
	cp $sp/cr3/lib/libdevice.so.1 $sp$fd/cr3/lib/libdevice.so.1
fi

if [ -d $sp/$qtcreatordir/cr3-kindle/src/data ]; then
	cp -r $sp/$qtcreatordir/cr3-kindle/src/data/* $sp$fd/cr3/data
else
	cp -r $sp/cr3/data/* $sp$fd/cr3/data
fi

cp $libspath/libexpat-bin/lib/libexpat.so.1.8.8 $sp$fd/cr3/lib/libexpat.so.1
cp $libspath/libfontconfig-bin/lib/libfontconfig.so.1.8.0 $sp$fd/cr3/lib/libfontconfig.so.1
cp $libspath/libjpeg-bin/lib/libjpeg.so.8.4.0 $sp$fd/cr3/lib/libjpeg.so.8
cp $libspath/libpng-bin/lib/libpng15.so.15.30.0 $sp$fd/cr3/lib/libpng15.so.15
cp $libspath/libz-bin/lib/libz.so.1.2.12 $sp$fd/cr3/lib/libz.so.1

if [ -f $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so ]; then
	cp $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so $sp$fd/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
else
	cp $sp/qtKindle/plugins/kbddrivers/libKindleKeyboard.so $sp$fd/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so $sp$fd/qtKindle/plugins/gfxdrivers/libQKindleFb.so
else
	cp $sp/qtKindle/plugins/gfxdrivers/libQKindleFb.so $sp$fd/qtKindle/plugins/gfxdrivers/libQKindleFb.so
fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so $sp$fd/qtKindle/plugins/mousedrivers/libKindleTS.so
else
	cp $sp/qtKindle/plugins/mousedrivers/libKindleTS.so $sp$fd/qtKindle/plugins/mousedrivers/libKindleTS.so
fi

cp $libspath/libfreetype-bin/lib/libfreetype.so.6.6.2 $sp$fd/qtKindle/lib/libfreetype.so.6
cp $qtdir/lib/libQtCore.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtCore.so.4
cp $qtdir/lib/libQtDBus.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtDBus.so.4
cp $qtdir/lib/libQtGui.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtGui.so.4
cp $qtdir/lib/libQtNetwork.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtNetwork.so.4
cp $qtdir/lib/libQtXml.so.4.$qtsubversion $sp$fd/qtKindle/lib/libQtXml.so.4

cp $libspath/libfreetype-bin/lib/pkgconfig/freetype2.pc $sp$fd/qtKindle/lib/pkgconfig/freetype2.pc
cp $qtdir/lib/pkgconfig/QtCore.pc $sp$fd/qtKindle/lib/pkgconfig/QtCore.pc
cp $qtdir/lib/pkgconfig/QtDBus.pc $sp$fd/qtKindle/lib/pkgconfig/QtDBus.pc
cp $qtdir/lib/pkgconfig/QtGui.pc $sp$fd/qtKindle/lib/pkgconfig/QtGui.pc
cp $qtdir/lib/pkgconfig/QtNetwork.pc $sp$fd/qtKindle/lib/pkgconfig/QtNetwork.pc
cp $qtdir/lib/pkgconfig/QtSql.pc $sp$fd/qtKindle/lib/pkgconfig/QtSql.pc
cp $qtdir/lib/pkgconfig/QtTest.pc $sp$fd/qtKindle/lib/pkgconfig/QtTest.pc
cp $qtdir/lib/pkgconfig/QtXml.pc $sp$fd/qtKindle/lib/pkgconfig/QtXml.pc
