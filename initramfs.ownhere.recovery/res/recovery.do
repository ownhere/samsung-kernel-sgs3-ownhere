

on multi-csc
	echo 
	echo "-- Appling Multi-CSC..."
	mount /system	
	echo "Applied the CSC-code : <salse_code>"
	cp -y -f -r -v /system/csc/common /
	unmount /system
	mount /system
	cmp -r /system/csc/common /	
	cp -y -f -r -v /system/csc/<salse_code> /
	unmount /system
	mount /system	
	cmp -r /system/csc/<salse_code> /	
	echo "Successfully applied multi-CSC."

on wipe-data
	echo "-- Deleting data"
	mount /data
	#rm -r -f --with-except=/data/media/autonavidata50/,/data/media/DioDict3B/ /data
	rm -r -f --with-except=/data/media/ /data
	ls /data
	echo "Successfully deleted data"
	
on factory-out
	echo "Coping medias..."
	mount /preload
	mount /data
	mkdir media_rw media_rw 0775 /data/media
	mkdir media_rw media_rw 0775 /data/media/Samsung
	mkdir media_rw media_rw 0775 /data/media/Samsung/Music
	mkdir media_rw media_rw 0775 /data/media/Samsung/Video
	cp -y -r -v -f --with-fmode=0664 --with-dmode=0775 --with-owner=media_rw.media_rw /preload/INTERNAL_SDCARD/Samsung/Music /data/media/Samsung/Music
	cp -y -r -v -f --with-fmode=0664 --with-dmode=0775 --with-owner=media_rw.media_rw /preload/INTERNAL_SDCARD/Samsung/Video /data/media/Samsung/Video
	unmount /data
	mount /data
	cmp -r /preload/INTERNAL_SDCARD/Samsung/Music /data/media/Samsung/Music
	cmp -r /preload/INTERNAL_SDCARD/Samsung/Video /data/media/Samsung/Video	
