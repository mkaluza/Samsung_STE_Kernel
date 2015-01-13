#! /system/bin/sh
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

