if [ -f "/link/config/reboot" ]; then
rm /link/config/reboot
reboot
fi

cfg=/link/config/ntp.json
enable=`cat $cfg | grep -o '"enable":[^(,|})]*' | awk -F: '{print $2}'`
server=`cat $cfg | grep -o '"server":[^(,|})]*' | awk -F\" '{print $4}'`
#echo $enable
#echo $server
if [ "$enable" = "true" ]; then
ntpd  -p $server
fi
/usr/sbin/crond -d 8


