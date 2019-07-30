ENDPOINT=172.20.13.241:5000
TARGET=iqn.2003-01.com.wuxingi:$1
CLIENT=iqn.2003-01.com.wuxingi:client$1
USERNAME=myiscsiusername
PASSWORD=myiscsipassword
POOL=rbd
DISK=$1

# 1. delete clientlun
#curl --insecure --user admin:admin -d disk=$POOL/$DISK -X DELETE http://$ENDPOINT/api/clientlun/$TARGET/$CLIENT

# 2. delete targetlun
curl --insecure --user admin:admin -d disk=$POOL/$DISK -X DELETE http://$ENDPOINT/api/targetlun/$TARGET

## 3. delete client
curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/client/$TARGET/$CLIENT
#
## 4. delete backend disk
curl --insecure --user admin:admin -d preserve_image=false -X DELETE http://$ENDPOINT/api/disk/$POOL/$DISK
#
## 5. create gateways for the target
curl --insecure --user admin:admin -d ip_address=172.20.13.241 -X DELETE http://$ENDPOINT/api/gateway/$TARGET/oceanstore-wuxingyi-node-0
curl --insecure --user admin:admin -d ip_address=172.20.13.242 -X DELETE http://$ENDPOINT/api/gateway/$TARGET/oceanstore-wuxingyi-node-1
curl --insecure --user admin:admin -d ip_address=172.20.13.168 -X DELETE http://$ENDPOINT/api/gateway/$TARGET/ceph168
#
## 6. create target
curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/target/$TARGET
