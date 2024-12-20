. /link/shell/util/hardware.sh
/link/shell/setMac.sh
sleep 1
if [ -f /link/config/misc/webVer.json ] && web=$(jq -r ".web" /link/config/misc/webVer.json) && [ "$web" != "classic" ] ;then
    cp /usr/nginx/conf/nginx_standard.conf /usr/nginx/conf/nginx.conf
    title=`grep -o '<title>.*</title>' /link/web/headhead.php  | sed -e 's/<title>\(.*\)<\/title>/\1/'`
    footer=`awk '/<div class="container">/,/<\/div>/' /link/web/foot.php  | grep -o '<div>.*<\/div>' | sed -e 's/<div>\(.*\)<\/div>/\1/' | sed -e 's/<\/div>//g'`
    sed -i "s/<title>.*<\/title>/<title>${title}<\/title>/" /link/webflex/public/headhead.inc
    sed -i '/<div class=".*d-flex.*">/,/<\/div>/ s/>[^<]*</>'"${footer}"'</g' /link/webflex/public/footfoot.inc
    rm -rf /link/webflex/assets/img
    ln -s /link/web/img /link/webflex/assets/
    rm -rf /link/webflex/.htaccess
    ln -s /link/web/.htaccess /link/webflex/
    cp /link/web/favicon.ico /link/webflex/
    sync
    /link/shell/net.sh &
    sleep 2
else
    cp /usr/nginx/conf/nginx_classic.conf /usr/nginx/conf/nginx.conf
    sync
    /link/shell/setNetwork.sh
    sleep 2
    /link/bin/WifiCtrl &
fi

if [ -d /sys/class/net/eth1 ]; then
    if [ -d /sys/class/net/eth2 ];then
	if [ "$fac" == "ENC2" ] || [ "$fac" == "ENC2V2" ] || [ "$fac" == "ENC2_SS528" ]; then
	    /link/shell/setMac2.sh eth2
	    /link/shell/setNetwork2.sh eth2
	fi
    else
	if [ "$fac" != "ENC2" ] && [ "$fac" != "ENC2V2" ] && [ "$fac" != "ENC2_SS528" ]; then
	    /link/shell/setMac2.sh eth1
	    /link/shell/setNetwork2.sh eth1
	fi
    fi
fi
