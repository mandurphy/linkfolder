
umount_usb(){
    mnt=`df -h | grep $1 | wc -l`
    count=0
    while [ $mnt -gt 0 -a $count -le 5 ]
    do
	umount -l -f $1
	mnt=`df -h | grep $1 | wc -l`
	count=`expr $count + 1`
	sleep 1
	if [ $count -ge 5 ];then
	    exit
	fi
    done
}

targetDisk=$1
diskFormat=$2
umount_usb $targetDisk
if [ $diskFormat == "ext4" ];then
    echo -e "\ny" | mkfs.ext4 -T largefile $targetDisk
else
    mkfs.vfat -F 32 $targetDisk
fi

