#!/bin/sh
if  [ $1 != "bound" ]; then
  exit 0
fi
if  [ "$ip" == "" ]; then
  exit 0
fi
echo "dhcp_result"
echo "dev:"$interface
echo "ip:"$ip
echo "mask:"$subnet
echo "gw:"$router
dns=`echo $dns |awk -F ' ' '{print $1}'`
echo "dns:"$dns
