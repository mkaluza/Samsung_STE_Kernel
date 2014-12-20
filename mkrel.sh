#!/bin/bash

build="release debug"

if [ -z "$1" ]; then
	echo "Usage: $0 version [build]"
	exit 1
fi

rel=$1
[ -n "$2" ] && build="$2"

set -x 

branch=`git rev-parse --abbrev-ref HEAD`

git checkout $rel

for ver in $build; do
	dest=rel/$rel/$ver
	[ -d $dest -a -z "$FORCE" ] && continue
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
