#!/bin/sh

. /etc/profile
. /link/shell/util/func.sh
jopen /link/config/misc/disk.json

used=`jget used`
if [ ! -z "$1" ] && [ $used != "$1" ];then
    exit
fi

enable=`jget enable`

umount_disk(){
    mnt=`df -h | grep /root/usb | wc -l`
    count=0
    while [ $mnt -eq 1 -a $count -le 5 ]
    do
        umount -l -f /root/usb
        mnt=`df -h | grep /root/usb | wc -l`
        count=`expr $count + 1`
        sleep 1
        if [ $count -ge 5 ];then
            exit
        fi
    done
}

had_mounted() {
    if [ $enable == "true" ];then
        mnt=`df -h | grep /root/usb | wc -l`
        echo $mnt
        return
    fi
    echo 0
}

umount_disk

if [ $enable == "true" ];then
    if [ $used == "shared" ];then
	if [ ! -z "$1" ];then
	    sleep 8
	fi
        ip=`jget shared.ip`
        type=`jget shared.type`
        uname=`jget shared.auth.uname`
        passwd=`jget shared.auth.passwd`
        path=`jget shared.path`
        if [ $type == "cifs" ];then
            target=//$ip$path
            if [ -z $uname ];then
                uname="x"
		passwd="x"
	    fi
	    mount -t $type -o nolock,username=$uname,password=$passwd $target /root/usb
	else
	    target=$ip:$path
	    mount -t $type -o nolock,tcp $target /root/usb
	fi
    fi
    if [ $used == "local" ];then
	device=`jget local.device`
	mount -t vfat -o rw,relatime,codepage=936,utf8 $device /root/usb
	mount -t ext4 $device /root/usb
	/usr/bin/ntfs-3g $device /root/usb
    fi
fi

had_mounted
