. /link/shell/util/func.sh

while [ true ]
do
jopen /link/config/ntp.json
if [ `jget enable` == "true" ]; then

    if [ -f "/usr/bin/ntpdate" ]; then
        if ! procExists ntpdate ;then
            ntpdate `jget server`
            if [[ $? == 0 ]];then
                sleep $((`jget interval`*60))
            fi                              
        fi
    else
        if ! procExists ntpd ;then
            ntpd  -p `jget server` -nq
            if [[ $? == 0 ]];then
                sleep $((`jget interval`*60))
            fi                              
        fi
    fi
else
    pkill ntpd
fi                         
sleep 1
done  
