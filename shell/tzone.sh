

if [ ! -f /link/config/misc/timezone/tzselect.json ];then
    exit
fi 

cfg=/link/config/misc/timezone/tzselect.json
area=`cat $cfg | grep -o '"timeArea":[^(,|})]*' | awk -F: '{print $2}' | sed 's/\"//g'`
city=`cat $cfg | grep -o '"timeCity":[^(,|})]*' | awk -F: '{print $2}' | sed 's/\"//g'`

if [ "$area" = "" -o "$city" = "" ];then
    exit
fi

cp /link/config/misc/timezone/zoneinfo/$area/$city /etc/localtime
