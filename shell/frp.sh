while [ true ]
do
pkill frpc
/link/bin/frpc -c /link/config/rproxy/frpc.ini
sleep 2
done  
