#!/system/bin/sh

BUSYBOX=busybox_recovery

if [ $# -lt 1 ]; then
	run=`getprop ownhere.backupefs.ready`
	if [ $run -eq 1 ]; then
		echo "already running..."
		exit 0
	fi

	setsid flock -x /init.rc -c $0 1 &
	exit;
fi

setprop ownhere.backupefs.ready 1

sleep 60 #wait for system bootup

if ! [ -e /mnt/sdcard/efs.backup.ownhere.tar.gz ]; then
	$BUSYBOX tar cf /mnt/sdcard/efs.backup.ownhere.tar /efs
	$BUSYBOX gzip /mnt/sdcard/efs.backup.ownhere.tar
fi
if [ -e /sys/block/mmcblk1/mmcblk1p1 ]; then
	if ! [ -e /mnt/extSdCard/efs.backup.ownhere.tar.gz ]; then
		$BUSYBOX tar cf /mnt/extSdCard/efs.backup.ownhere.tar /efs
		$BUSYBOX gzip /mnt/extSdCard/efs.backup.ownhere.tar
	fi
fi
