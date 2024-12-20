echo 88`echo $RANDOM | md5sum | sed 's/\(..\)/&/g' | cut -c1-10`
