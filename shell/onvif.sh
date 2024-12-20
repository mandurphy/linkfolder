cd /link/bin/onvif
./wsdd --if_name eth0 --type tdn:NetworkVideoTransmitter --xaddr http://%s:1000/onvif/device_service --scope "onvif://www.onvif.org/name/Unknown onvif://www.onvif.org/Profile/Streaming" --endpoint "urn:uuid:5bc00730-1787-4e12-ab8b-4567327b23c7"

./onvif_srvd --ifs eth0 --scope onvif://www.onvif.org/name/LinkPi --scope onvif://www.onvif.org/Profile/S \
--name stream0 --width 1920 --height 1080 --url rtsp://%s/stream0 --type H264 \
--name sub0 --width 640 --height 360 --url rtsp://%s/sub0 --type H264 
