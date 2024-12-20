cfg=/link/config/net2.json

ip=`cat $cfg | grep -o '"ip":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
mask=`cat $cfg | grep -o '"mask":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
gw=`cat $cfg | grep -o '"gateway":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
dns=`cat $cfg | grep -o '"dns":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
dhcp=`cat $cfg | grep -o '"dhcp":[^(,|})]*' | awk -F: '{print $2}'`



ifconfig $1 $ip netmask $mask up
if [ "$dhcp" == "true" ]; then
ifconfig $1 up
udhcpc -i $1 -b -s /link/shell/dhcp.sh > /dev/null &
fi
