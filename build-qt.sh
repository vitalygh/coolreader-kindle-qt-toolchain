#!/bin/sh
libname=qt
. ./build-config.sh

libdir=$libname-everywhere-opensource-src-$qtversion
libfile=$libdir.tar.gz
liburl=https://download.qt.io/archive/qt/$qtvera.$qtverb/$qtversion/$libfile

libbinpath=$libqtpath
[ -z "$libbinpath" ] && libbinpath=$scriptpath/qtKindle
if [ -d $libbinpath/lib ]; then
	echo $libname already builded, skip
	exit
fi

[ -z "$libdbuspath" ] && libdbuspath=$libspath/libdbus-bin
[ -z "$libdbusx64path" ] && libdbusx64path=$libspath/libdbus-x64-bin

mkdir -p $libspath
#mkdir -p $buildpath
#cd $libspath/
rm -fr $libbinpath
mkdir -p $libbinpath
cd $buildpath
rm -fr $libname-build
mkdir -p $libname-build

if [ ! -d $libdir ]; then
	if [ ! -f $libfile ]; then
		wget $liburl
	fi
	tar xvf $libfile
fi

if [ -d $scriptpath/patch/$libname-$qtversion ] && [ -d $buildpath/$libdir ]; then
	cp -R $scriptpath/patch/$libname-$qtversion/* $buildpath/$libdir
	sed -i "s+armcompiller+$qmakecompiller+" $buildpath/$libdir/mkspecs/qws/linux-arm-kindle-g++/qmake.conf
	sed -i "s+armflags+$qmakeflags+" $buildpath/$libdir/mkspecs/qws/linux-arm-kindle-g++/qmake.conf	
	#sed -i "s+armrpath+$qmakerpath+" $buildpath/$libdir/mkspecs/qws/linux-arm-kindle-g++/qmake.conf	
fi

cd $libname-build

$buildpath/$libdir/configure -v \
	-embedded arm \
	-xplatform qws/linux-arm-kindle-g++ \
	-little-endian \
	-opensource \
	-confirm-license \
	-prefix $libbinpath \
	-no-qt3support \
	-no-sql-sqlite \
	-no-accessibility \
	-no-xmlpatterns \
	-no-multimedia \
	-no-audio-backend \
	-no-phonon \
	-no-phonon-backend \
	-no-svg \
	-no-webkit \
	-no-javascript-jit \
	-no-script \
	-no-scripttools \
	-no-declarative \
	-no-declarative-debug \
	-no-fast \
	-no-zlib \
	-no-libpng \
	-no-openssl \
	-no-nis \
	-no-cups \
	-no-iconv \
	-no-gtkstyle \
	-no-nas-sound \
	-no-opengl \
	-no-openvg \
	-no-sm \
	-no-xshape \
	-no-xvideo \
	-no-xsync \
	-no-xinerama \
	-no-xcursor \
	-no-xfixes \
	-no-xrandr \
	-no-fontconfig \
	-no-xinput \
	-no-xkb \
	-no-glib \
	-no-mmx \
	-no-3dnow \
	-no-sse \
	-no-sse2 \
	-no-sse3 \
	-no-ssse3 \
	-no-sse4.1 \
	-no-sse4.2 \
	-no-avx \
	-no-neon \
	-release \
	-nomake examples \
	-nomake demos \
	-dbus-linked \
	-I$libdbuspath/include/dbus-1.0 \
	-I$libdbuspath/lib/dbus-1.0/include \
	-L$libdbuspath/lib \
	-L$libdbusx64path/lib \
	-ldbus-1 &&
	
# failed to remove:
#	-no-stl \

#	-no-gif \
#	-no-libtiff \
#	-no-libmng \
#	-no-libjpeg \

# -no-pch \
#	-dbus \
#	-dbus-linked \
#	-L$libspath/libdbus-x64-bin/lib \

#	-no-rpath \

#	-I$libspath/libdbus-bin/include \
#	-I$libspath/libdbus-bin/include/dbus-1.0 \
#	-I$libspath/libdbus-bin/include/dbus-1.0/dbus \
#	-I$libspath/libdbus-bin/lib/dbus-1.0/include \
	

# -nomake tools
# -no-style-windows -no-style-windowsxp -no-style-windowsvista
#	-I$libspath/libdbus-x64-bin/include \
#	-I$libspath/libdbus-x64-bin/include/dbus-1.0 \
#	-I$libspath/libdbus-x64-bin/include/dbus-1.0/dbus \
#	-I$libspath/libdbus-x64-bin/lib/dbus-1.0/include \
#	-L$libspath/libdbus-x64-bin/lib \
#	-I$libspath/libexpat-bin/include \
#	-L$libspath/libexpat-bin/lib \
#	-lexpat \

make clean &&
make -j$cores -l$cores &&
make install &&
echo Success!

