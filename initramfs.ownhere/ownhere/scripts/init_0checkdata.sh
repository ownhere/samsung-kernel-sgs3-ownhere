#!/system/bin/sh

exit 0

BUSYBOX=/system/xbin/busybox

sync;sync;sync
$BUSYBOX umount /cache
/system/bin/e2fsck -f -y /dev/block/mmcblk0p8 > /data/checkcache.log 2>&1
$BUSYBOX mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,commit=19,journal_async_commit /dev/block/mmcblk0p8 /cache
$BUSYBOX mount -o remount,rw,nosuid,nodev,noatime,barrier=1,commit=19,journal_async_commit /dev/block/mmcblk0p8 /cache
$BUSYBOX rm -r /cache/lost+found/

exit 0

sleep 1
$BUSYBOX umount /data
/system/bin/e2fsck -f -y /dev/block/mmcblk0p12 > /cache/checkdata.log 2>&1
$BUSYBOX mount -t ext4 -o rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,journal_async_commit,noauto_da_alloc,discard /dev/block/mmcblk0p12 /data
$BUSYBOX mount -o remount,rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,journal_async_commit,noauto_da_alloc,discard /dev/block/mmcblk0p12 /data
$BUSYBOX rm -r /data/lost+found/
