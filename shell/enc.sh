while [ true ]
do
if [ -f "/root/usb/Tester" ]; then
    chmod 777 /root/usb/Tester
    /root/usb/Tester
else
    if [ -f "/link/bin/Monitor" ];then
        pkill Monitor
    fi
    if [ -f "/root/usb/config.json" ];then
	/link/bin/Encoder -c /root/usb/config.json
    else
	/link/bin/Encoder
    fi
fi
sleep 2
done  
