ENDPOINT=172.20.13.242:5000
POOL=rbd
DISK=dididi

curl --insecure --user admin:admin  -X GET http://$ENDPOINT/api/disk/qos/$POOL/$DISK
