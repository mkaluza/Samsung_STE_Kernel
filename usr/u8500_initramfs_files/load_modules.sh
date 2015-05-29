#! /system/bin/sh
if [ ! -e /system/etc/modules ]; then
	echo "Module loadedr: /system/etc/modules not found. Exiting"
	exit 1
fi

modules=`cat /system/etc/modules | grep -v "#" | sed -e "s/[ \t]//g"`
for m in $modules; do
	mm=/system/lib/modules/${m}.ko
	if [ -f $mm ]; then
		echo "Loading $mm"
		insmod $mm
	else
		echo "Module $m not found in /system/lib/modules/"
	fi
done

