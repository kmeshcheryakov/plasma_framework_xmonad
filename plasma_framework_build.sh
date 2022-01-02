#!/bin/env bash


pwd=`pwd`
cd /tmp
/usr/bin/asp update
/usr/bin/asp checkout plasma-framework
cd plasma-framework/repos/extra-x86_64 

cp $pwd/xmonad-regression.patch .
cp PKGBUILD PKGBUILD_NEW
sed -i 's_$pkgname-$pkgver.tar.xz{,.sig}_$pkgname-$pkgver.tar.xz{,.sig} xmonad-regression.patch_g' PKGBUILD_NEW
sed -i "s_'SKIP'_'SKIP' 'SKIP'_g" PKGBUILD_NEW

cat >> PKGBUILD_NEW << EndOfMessage
prepare() {
  mkdir -p build
  cd \$pkgname-\$pkgver
  patch -p1 < ../xmonad-regression.patch
}
EndOfMessage

makepkg -p PKGBUILD_NEW -i

