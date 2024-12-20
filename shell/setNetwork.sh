. /link/shell/util/func.sh

if [ -f /root/usb/local ];then
  cp /root/usb/local /link/config/net.json
fi

cfg=/link/config/net.json
ip=`cat $cfg | grep -o '"ip":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
if [ "$ip" == "" ]; then
cp /link/config/default/net.json /link/config/net.json
ip=`cat $cfg | grep -o '"ip":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
fi
mask=`cat $cfg | grep -o '"mask":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
gw=`cat $cfg | grep -o '"gateway":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
dns=`cat $cfg | grep -o '"dns":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
dhcp=`cat $cfg | grep -o '"dhcp":[^(,|})]*' | awk -F: '{print $2}'`



ifconfig lo 127.0.0.1
ifconfig eth0:0 192.168.88.88 netmask 255.255.255.0 up


echo $ip
echo $mask
ifconfig eth0 $ip netmask $mask up
echo $gw
route add default gw $gw
echo nameserver $dns > /etc/resolv.conf

echo $ip > /etc/hostname
hostname -F /etc/hostname

if [ ! -f /root/usb/local -a "$dhcp" == "true" ]; then
    ifconfig eth0 up
    if ! procExists udhcpc ;then
        udhcpc -i eth0 -b -s /link/shell/dhcp.sh > /dev/null &
    fi
else
    pkill udhcpc
fi
