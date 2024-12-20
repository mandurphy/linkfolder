/link/shell/enc.sh &
/link/shell/gpio.sh &

if [ -f /link/bin/PortCtrl ] ;then
/link/bin/PortCtrl &
fi

if [ -f /link/bin/PTZ ] ;then
/link/shell/ptz.sh &
fi

if [ -f /link/bin/mqtt ] ;then
/link/bin/mqtt &
fi

if [ -f /link/bin/Monitor ];then
/link/shell/monitor.sh &
fi

if [ -f /link/bin/TFT ];then
/link/shell/tft.sh &
fi
