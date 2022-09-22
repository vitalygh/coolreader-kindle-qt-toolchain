#!/bin/sh
qtcreatordir=build-coolreader-Desktop-Release
finaldir=final
. ./build-config.sh

if [ -d $scriptpath/$finaldir/qtKindle/lib ]; then
	echo $finaldir already builded, skip
	exit
fi

sp=$scriptpath
#rm -fr $sp/$finaldir/qtKindle/lib
mkdir -p $sp/$finaldir
mkdir -p $sp/$finaldir/cr3
mkdir -p $sp/$finaldir/cr3/lib
mkdir -p $sp/$finaldir/qtKindle
mkdir -p $sp/$finaldir/qtKindle/plugins
mkdir -p $sp/$finaldir/qtKindle/plugins/kbddrivers
mkdir -p $sp/$finaldir/qtKindle/plugins/gfxdrivers
mkdir -p $sp/$finaldir/qtKindle/plugins/mousedrivers
mkdir -p $sp/$finaldir/qtKindle/lib
mkdir -p $sp/$finaldir/qtKindle/lib/pkgconfig

if [ -f $sp/$qtcreatordir/cr3-kindle/src/cr3 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/cr3 $sp/$finaldir/cr3/cr3
#else
	#cp $sp/mnt/us/cr3/cr3 $sp/$finaldir/cr3/cr3
fi

if [ -f $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 ]; then
	cp $sp/$qtcreatordir/cr3-kindle/src/device/libdevice.so.1.0.0 $sp/$finaldir/cr3/lib/libdevice.so.1
#else
	#cp $sp/mnt/us/cr3/lib/libdevice.so.1 $sp/$finaldir/cr3/lib/libdevice.so.1
fi

cp $libspath/libexpat-bin/lib/libexpat.so.1.8.8 $sp/$finaldir/cr3/lib/libexpat.so.1
cp $libspath/libfontconfig-bin/lib/libfontconfig.so.1.8.0 $sp/$finaldir/cr3/lib/libfontconfig.so.1
cp $libspath/libjpeg-bin/lib/libjpeg.so.8.4.0 $sp/$finaldir/cr3/lib/libjpeg.so.8
cp $libspath/libpng-bin/lib/libpng15.so.15.30.0 $sp/$finaldir/cr3/lib/libpng15.so.15
cp $libspath/libz-bin/lib/libz.so.1.2.12 $sp/$finaldir/cr3/lib/libz.so.1

if [ -f $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so ]; then
	cp $sp/$qtcreatordir/drivers/KindleKeyboard/libKindleKeyboard.so $sp/$finaldir/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
#else
	#cp $sp/mnt/us/qtKindle/plugins/kbddrivers/libKindleKeyboard.so $sp/$finaldir/qtKindle/plugins/kbddrivers/libKindleKeyboard.so
fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/QKindleFb/libQKindleFb.so $sp/$finaldir/qtKindle/plugins/gfxdrivers/libQKindleFb.so
#else
	#cp $sp/mnt/us/qtKindle/plugins/gfxdrivers/libQKindleFb.so $sp/$finaldir/qtKindle/plugins/gfxdrivers/libQKindleFb.so
fi
if [ -f $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so ]; then
	cp $sp/build-coolreader-Desktop-Release/drivers/KindleTS/libKindleTS.so $sp/$finaldir/qtKindle/plugins/mousedrivers/libKindleTS.so
#else
	#cp $sp/mnt/us/qtKindle/plugins/mousedrivers/libKindleTS.so $sp/$finaldir/qtKindle/plugins/mousedrivers/libKindleTS.so
fi

cp $libspath/libfreetype-bin/lib/libfreetype.so.6.6.2 $sp/$finaldir/qtKindle/lib/libfreetype.so.6
cp $libspath/qt-bin/lib/libQtCore.so.4.8.7 $sp/$finaldir/qtKindle/lib/libQtCore.so.4
cp $libspath/qt-bin/lib/libQtDBus.so.4.8.7 $sp/$finaldir/qtKindle/lib/libQtDBus.so.4
cp $libspath/qt-bin/lib/libQtGui.so.4.8.7 $sp/$finaldir/qtKindle/lib/libQtGui.so.4
cp $libspath/qt-bin/lib/libQtNetwork.so.4.8.7 $sp/$finaldir/qtKindle/lib/libQtNetwork.so.4
cp $libspath/qt-bin/lib/libQtXml.so.4.8.7 $sp/$finaldir/qtKindle/lib/libQtXml.so.4

cp $libspath/libfreetype-bin/lib/pkgconfig/freetype2.pc $finaldir/qtKindle/lib/pkgconfig/freetype2.pc
cp $libspath/qt-bin/lib/pkgconfig/QtCore.pc $finaldir/qtKindle/lib/pkgconfig/QtCore.pc
cp $libspath/qt-bin/lib/pkgconfig/QtDBus.pc $finaldir/qtKindle/lib/pkgconfig/QtDBus.pc
cp $libspath/qt-bin/lib/pkgconfig/QtGui.pc $finaldir/qtKindle/lib/pkgconfig/QtGui.pc
cp $libspath/qt-bin/lib/pkgconfig/QtNetwork.pc $finaldir/qtKindle/lib/pkgconfig/QtNetwork.pc
cp $libspath/qt-bin/lib/pkgconfig/QtSql.pc $finaldir/qtKindle/lib/pkgconfig/QtSql.pc
cp $libspath/qt-bin/lib/pkgconfig/QtTest.pc $finaldir/qtKindle/lib/pkgconfig/QtTest.pc
cp $libspath/qt-bin/lib/pkgconfig/QtXml.pc $finaldir/qtKindle/lib/pkgconfig/QtXml.pc
