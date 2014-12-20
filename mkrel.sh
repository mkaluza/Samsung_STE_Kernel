#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 version"
	exit 1
fi

rel=$1
set -x 

branch=`git rev-parse --abbrev-ref HEAD`

git checkout $rel

for ver in release debug; do
	dest=rel/$rel/$ver
	[ -d $dest ] && continue
	make mk_${ver}_defconfig
	make -j 4
	mkdir -p $dest
	TMP=`mktemp -d`
	cp `find -iname *.ko` $TMP

	cp arch/arm/boot/zImage $dest
	cd $TMP
	zip $OLDPWD/$dest/modules.zip *
	rm -rf $TMP
	cd -
done

git checkout $branch
