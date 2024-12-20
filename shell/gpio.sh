. /link/shell/util/hardware.sh
count=0
type=`jget gpio.type`
himmGPIO()
{
    gpioName=`jget gpio.name`
    gpioAddr=`jget gpio.addr`
    eval "`jget gpio.mux` > /dev/null" 
    eval "`jget gpio.dir` > /dev/null"
    
    echo "Init $gpioName($gpioAddr) done."

    while [ true ]
    do
        ret=`himd.l  $gpioAddr 1 | awk 'NR==4{print $2}'`
        if [ "$ret" == "00000000" ]; then
            count=$(($count+1))
            echo "keyDown $count" 
            if [ "$count" == "5" ]; then
                echo "reset default config"
                /link/shell/reset.sh
            fi
        else
            count=0
        fi
        sleep 1
    done
}

sysfsGPIO()
{
    gpioName=`jget gpio.name`
    gpioIndex=`jget gpio.index`
    eval "`jget gpio.mux` > /dev/null"
    if [ ! -d "/sys/class/gpio/gpio$gpioIndex" ];then
        echo $gpioIndex > /sys/class/gpio/export
    fi
    echo "in" > /sys/class/gpio/gpio$gpioIndex/direction
    
    echo "Init $gpioName($gpioIndex) done."
    
    while [ true ]
    do
        ret=`cat /sys/class/gpio/gpio$gpioIndex/value`
        if [ "$ret" == "0" ]; then
            count=$(($count+1))
            echo "keyDown $count" 
            if [ "$count" == "5" ]; then
                echo "reset default config"
                /link/shell/reset.sh
            fi
        else
            count=0
        fi
        sleep 1
    done
}

if [ "$type" == "himm" ]; then
    himmGPIO
elif [ "$type" == "sysfs" ]; then 
    sysfsGPIO
fi
