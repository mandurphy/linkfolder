#!/bin/sh
if  [ $1 != "bound" ]; then
  exit 0
fi
if  [ "$ip" == "" ]; then
  exit 0
fi
dns=`echo $dns |awk -F ' ' '{print $1}'`
echo "dhcp_result"
echo "dev:"$interface
echo "ip:"$ip
echo "mask:"$subnet
echo "gw:"$router
echo "dns:"$dns

ifconfig $interface $ip netmask $subnet up
route del default
route add default gw $router
echo nameserver $dns > /etc/resolv.conf

if [ "$interface" = "eth0" ]; then
echo '{"dhcp":true,"ip":"'$ip'","mask":"'$subnet'","gateway":"'$router'","dns":"'$dns'"}' > /link/config/net.json
echo $ip > /etc/hostname
hostname -F /etc/hostname
else
echo '{"dhcp":true,"ip":"'$ip'","mask":"'$subnet'","gateway":"'$router'","dns":"'$dns'"}' > /link/config/net2.json
fi
