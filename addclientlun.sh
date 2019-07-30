ENDPOINT=172.20.13.241:5000
TARGET=iqn.2003-01.com.wuxingi:$1
CLIENT=iqn.2003-01.com.wuxingi:client$1
USERNAME=myiscsiusername
PASSWORD=myiscsipassword
POOL=rbd
DISK=$1

# 1. add to targetlun
curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/targetlun/$TARGET

# 2. add to clientlun
curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/clientlun/$TARGET/$CLIENT
ceph osd blacklist ls
ceph osd blacklist clear
