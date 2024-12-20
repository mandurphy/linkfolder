if [ ! -f "/link/config/mac2" ] || [ ! -s /link/config/mac2 ] || [ -z "$(cat /link/config/mac2)" ]; then
/link/shell/makeMac.sh > /dev/null
/link/shell/makeMac.sh > /link/config/mac2
fi

/sbin/ifconfig $1 down
/sbin/ifconfig $1 hw ether `cat /link/config/mac2`
/sbin/ifconfig $1 up
