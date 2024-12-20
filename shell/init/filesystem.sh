path="local"
if [ -z "$1" ] || [ "$1" == "local" ];then
    mkdir /tmp/snap
    mkdir /tmp/hls
    mkdir /tmp/log
    if [ ! -d /root/usb ]; then
        mkdir /root/usb
    fi

    if [ -b /dev/mmcblk0p5 ]; then
        /bin/mount -o remount,rw,sync,barrier=0 /dev/mmcblk0p5 /
    fi
    if [ ! -z "$1" ];then
        path=$1
    fi
fi

/link/shell/mount.sh $path

