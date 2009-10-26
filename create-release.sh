#!/bin/sh
# Build all files to upload to PPA.

version=`cat debian/control | grep ^Standards-Version: | awk '{print $2}'`
dir=gedit-gmate-$version

if [ -d build ]; then
    rm -R build
fi
mkdir -p build/$dir
cd build/$dir

for file in `ls -A ../../ | grep -v build`; do
    cp -R ../../$file ./
done

rm -Rf .git
rm -Rf build
for file in `find . -name \*.gitignore`; do cp -R $file ./; done

debuild

cd ..
rm -R $dir

for file in `ls ./ | grep -v .deb`; do
    rm $file
done

cd ..