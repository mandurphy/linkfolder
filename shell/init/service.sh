. /link/shell/util/func.sh
jopen /link/config/service.json

/link/bin/rtc -g time

if [ `jget telnet` == "true" ]; then
/usr/sbin/telnetd
fi

if [ `jget ssh` == "true" ] && ! procExists sshd; then
if [ ! -d /var/empty ];then
    mkdir -p /var/empty
fi
chown root:root /var/empty
/usr/local/sbin/sshd
fi

if [ `jget php` == "true" ]; then
/usr/php/sbin/php-fpm -R -p /usr/php -c /usr/php/etc/php.ini
fi

if [ `jget nginx` == "true" ]; then
/usr/nginx/sbin/nginx -p /usr/nginx
fi

if [ `jget crond` == "true" ]; then
if [ ! -f /var/spool/cron/crontabs/root ];then
    touch /var/spool/cron/crontabs/root
    echo "" >> /var/spool/cron/crontabs/root
    echo "" >> /var/spool/cron/crontabs/root
    echo "" >> /var/spool/cron/crontabs/root
fi
chown -R root:root /var/spool
/usr/sbin/crond -d 8
fi

if [ `jget onvif` == "true" ]; then
/link/shell/onvif.sh
fi

if [ `jget ndi` == "true" ]; then
/link/shell/ndi.sh
fi

if [ `jget sls` == "true" ]; then
/link/bin/sls -c /link/config/sls.conf &
fi

/link/shell/ntp.sh &

frp_enable=$(cat /link/config/rproxy/frp_enable |awk '{printf "%s",$1}')
if [ "$frp_enable" == "true" ]; then
/link/shell/frp.sh &
fi
