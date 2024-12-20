while [ true ]
do
    if [ -f "/root/usb/netManager.json" ];then
        /link/bin/NetManager -n /root/usb/netManager.json
    else
        /link/bin/NetManager
    fi
    sleep 2
done  
