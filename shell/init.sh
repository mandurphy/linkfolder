. /etc/profile
. /link/shell/util/func.sh
. /link/shell/util/hardware.sh

/link/shell/update.sh
ifconfig lo 127.0.0.1
/sbin/sysctl -p /etc/sysctl.conf
/link/shell/init/chip.sh

if nfsBoot ;then
/link/shell/init/filesystem.sh local
/link/shell/init/service.sh
else
/link/shell/init/filesystem.sh local
/link/shell/netManager.sh
/link/shell/init/filesystem.sh shared
/link/shell/init/service.sh
/link/shell/init/rtty.sh
/link/shell/app.sh 
fi






