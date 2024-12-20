if [ ! -f "/link/config/mac" ] || [ ! -s /link/config/mac ] || [ -z "$(cat /link/config/mac)" ]; then
/link/shell/makeMac.sh > /link/config/mac

ethaddr=`fw_printenv ethaddr | grep ethaddr | awk -F '=' '{print $2}' | sed 's/\://g'`
if echo "$ethaddr" | grep -q "34C8D62" ; then
  echo $ethaddr > /link/config/mac
fi

fi

/sbin/ifconfig eth0 down
/sbin/ifconfig eth0 hw ether `cat /link/config/mac`
/sbin/ifconfig eth0 up
