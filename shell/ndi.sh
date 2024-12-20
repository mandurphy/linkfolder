ip=`cat /link/config/net.json | grep -o '"ip":[0-9|.|"| ]*' | awk -F\" '{print $4}'`
if [ -f /link/config/misc/webVer.json ] && web=$(jq -r ".web" /link/config/misc/webVer.json) && [ "$web" != "classic" ] ;then
ip=$(jq -r ".interface.eth0.ip" /link/config/netManager.json)
fi
echo $ip > /etc/hostname
hostname -F /etc/hostname
if [ -f "/link/config/mac" ]; then
sed -i "s/host-name=.*/host-name=`cat /link/config/mac`/g" /etc/avahi/avahi-daemon.conf
else
sed -i "s/host-name=.*/host-name=test/g" /etc/avahi/avahi-daemon.conf
fi

if [ -f /usr/local/var/run/dbus/pid ] ;then
rm /usr/local/var/run/dbus/pid
fi

if [ -f /run/avahi-daemon/pid ] ;then
rm /run/avahi-daemon/pid
fi

sleep 5
/link/bin/dbus-daemon --config-file=/etc/dbus-1/system.conf
/link/bin/avahi-daemon -f /etc/avahi/avahi-daemon.conf -D
