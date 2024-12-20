. /link/shell/util/hardware.sh
cfg=/link/config/rtty.json
ver=/link/config/version.json

#model=${model:4}
sys=`jq -r .sys $ver`
build=`echo $sys | sed 's/\"//g' | awk '{split($1, arr, " "); print arr[1]}'`

(
  while [ true ]
  do
    enable=`jq -r .enable $cfg`
    if [ "$enable" == "true" ] ;then
      ip=`jq -r .ip $cfg`
      id=`jq -r .id $cfg`
      des=`jq -r .des $cfg`
      token=`jq -r .token $cfg`
      if [ "$des" == "" ];then
        des=$model" build "$build
      else
	des=$des" ( "$model" build "$build" )"
      fi
      if [ "$token" == "" ] ;then
        rtty -I "$id" -h $ip -p 5912 -a -v -d "$des"
      else
        rtty -I "$id" -h $ip -p 5912 -a -v -d "$des" -t $token
      fi
    fi
    sleep 2
 done
) & 

