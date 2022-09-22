#!/bin/sh
libdir=coolreader-kindle-qt
liburl=https://github.com/CrazyCoder/$libdir
librevision=5a85ba1f0b30f67b4a3ea029d1f50a5709c6c1f0
. ./build-config.sh

binpath=$crpath
libpath=$buildpath/$libdir
[ -z "$binpath" ] && binpath=$scriptpath/cr3

if [ -f $binpath/cr3 ]; then
	echo $libdir already builded, skip
	exit
fi

#rm -fr $libpath

if [ ! -d $libpath ]; then
	git clone --recurse-submodules $liburl $libpath
	
	#if [ ! -f $libfile ]; then
	#	git archive --remote=$liburl --format=tar.gz --output $libdir.tar.gz $librevision
	#fi
	#tar xvf $libfile.tar.gz
	
fi

git -C $libpath clean -fd
git -C $libpath checkout .
git -C $libpath pull --ff-only
git -C $libpath checkout $librevision
	
#sed -i "s*# arm {*arm {*" $libpath/coolreader.pro
#sed -i "s*arm {*# arm {*" $libpath/coolreader.pro
#sed -i "s*# }*}*" $libpath/coolreader.pro
#sed -i "s*}*# }*" $libpath/coolreader.pro

#sed -i "s*drivers/KindleTS drivers/KindleFiveWay*drivers/KindleTS*" $libpath/coolreader.pro
sed -i "s*drivers/KindleTS*drivers/KindleTS drivers/KindleFiveWay*" $libpath/coolreader.pro

sed -i "s*target.path = /mnt/us/cr3*target.path = $binpath*" $libpath/cr3-kindle/src/src.pro
sed -i "s*trans.path = /mnt/us/cr3/data/i18n*trans.path = $binpath/data/i18n*" $libpath/cr3-kindle/src/src.pro

#sed -i "s*# arm {*arm {*" $libpath/cr3-kindle/src/src.pro
#sed -i "s*arm {*# arm {*" $libpath/cr3-kindle/src/src.pro

alllibs="LIBS += -L\$\$PWD/../libs/kindle -L$libzpath/lib -lz -L$libpngpath/lib -lpng -L$libfreetypepath/lib -lfreetype -L$libfontconfigpath/lib -lfontconfig -L$libexpatpath/lib -lexpat -L$libjpegpath/lib -ljpeg"
#sed -i "s*$alllibs*LIBS += -L\$\$PWD/../libs/kindle -lz -lpng -lfreetype -lfontconfig -ljpeg*" $libpath/cr3-kindle/src/src.pro
##sed -i "s*LIBS += -L\$\$PWD/../libs/kindle -lz -lpng -lfreetype -lfontconfig -ljpeg*$alllibs*" $libpath/cr3-kindle/src/src.pro

#sed -i "s*#} else {*} else {*" $libpath/cr3-kindle/src/src.pro
#sed -i "s*} else {*#} else {*" $libpath/cr3-kindle/src/src.pro

#sed -i "s*#LIBS += -L\$\$PWD/../libs/desktop \`pkg-config --libs zlib libpng freetype2 fontconfig jpeg\`*LIBS += -L\$\$PWD/../libs/desktop \`pkg-config --libs zlib libpng freetype2 fontconfig jpeg\`*" $libpath/cr3-kindle/src/src.pro
##sed -i "s*LIBS += -L\$\$PWD/../libs/desktop \`pkg-config --libs zlib libpng freetype2 fontconfig jpeg\`*#LIBS += -L\$\$PWD/../libs/desktop \`pkg-config --libs zlib libpng freetype2 fontconfig jpeg\`*" $libpath/cr3-kindle/src/src.pro

#sed -i "s*# }*}*" $libpath/cr3-kindle/src/src.pro
#sed -i "s*}*# }*" $libpath/cr3-kindle/src/src.pro

sed -i "s*dlib.path = /mnt/us/cr3/lib*dlib.path = $binpath/lib*" $libpath/cr3-kindle/src/device/device.pro

allincludes="../thirdparty/antiword $libfreetypepath/include $libfreetypepath/include/freetype2 $libzpath/include $libfontconfigpath/include $libpngpath/include $libjpegpath/include"
#sed -i "s*$allincludes*../thirdparty/antiword*" $libpath/crengine/crengine/crengine.pro
##sed -i "s*../thirdparty/antiword*$allincludes*" $libpath/crengine/crengine/crengine.pro

sed -i "s*target.path = /mnt/us/qtKindle/plugins/kbddrivers*target.path = $libqtpath/plugins/kbddrivers*" $libpath/drivers/KindleKeyboard/KindleKeyboard.pro

sed -i "s*target.path = /mnt/us/qtKindle/plugins/mousedrivers*target.path = $libqtpath/plugins/mousedrivers*" $libpath/drivers/KindleTS/KindleTS.pro

sed -i "s*target.path = /mnt/us/qtKindle/plugins/gfxdrivers*target.path = $libqtpath/plugins/gfxdrivers*" $libpath/drivers/QKindleFb/QKindleFb.pro

if ! grep -q "INSTALLS += target" $libpath/drivers/KindleFiveWay/KindleFiveWay.pro; then
	sed -i "s*DESTDIR = \$\$(QTDIR)/plugins/mousedrivers**" $libpath/drivers/KindleFiveWay/KindleFiveWay.pro
	#\nLIBS += -L$$OUT_PWD/../../cr3-kindle/src/device/ -ldevice\nINCLUDEPATH += $$PWD/../../cr3-kindle/src/device\nDEPENDPATH += $$PWD/../../cr3-kindle/src/device
	echo "\ntarget.path = $libqtpath/plugins/mousedrivers\nINSTALLS += target\n" >> $libpath/drivers/KindleFiveWay/KindleFiveWay.pro
fi

if [ -d $scriptpath/patch/$libdir ] && [ -d $libpath ]; then
	cp-R $scriptpath/patch/$libdir/* $libpath
fi

cwd=$(pwd)
cd $libpath
make distclean

$libqtpath/bin/qmake coolreader.pro "CONFIG+=arm" "$alllibs" "INCLUDEPATH+=$allincludes" &&
make -j$cores -l$cores &&
make install &&
touch $libpath/cr3-kindle/src/src.pro &&
touch $libpath/cr3-kindle/src/device/device.pro &&
$libqtpath/bin/qmake coolreader.pro "CONFIG+=arm" "$alllibs" "INCLUDEPATH+=$allincludes" &&
make -j$cores -l$cores &&
make install &&
echo Success!

cd $cwd
