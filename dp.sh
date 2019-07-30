ENDPOINT=172.20.13.241:5000
TARGET=iqn.2003-01.com.wuxingi:$1
CLIENT=iqn.2003-01.com.wuxingi:client$1
USERNAME=myiscsiusername
PASSWORD=myiscsipassword
POOL=rbd
DISK=$1


# 1. create target
curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/target/"$TARGET"test1
curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/target/"$TARGET"test2

# 2. create gateways for the target
curl --insecure --user admin:admin -d ip_address=172.20.13.241 -X PUT http://$ENDPOINT/api/gateway/"$TARGET"test1/oceanstore-wuxingyi-node-241
curl --insecure --user admin:admin -d ip_address=172.20.13.241 -X PUT http://$ENDPOINT/api/gateway/"$TARGET"test2/oceanstore-wuxingyi-node-241

curl --insecure --user admin:admin -d create_image=true -d mode=create -d size=10M -d count=1 -X PUT http://$ENDPOINT/api/disk/$POOL/"$DISK"

# 3. create a rbd backend disk
curl --insecure --user admin:admin -d disk=$POOL/"$DISK""$i" -X PUT http://$ENDPOINT/api/targetlun/"$TARGET"test1
curl --insecure --user admin:admin -d disk=$POOL/"$DISK""$i" -X PUT http://$ENDPOINT/api/targetlun/"$TARGET"test2

# 4. create client
curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/client/"$TARGET"test1/$CLIENT
curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/client/"$TARGET"test2/$CLIENT

# 5. set chap auth for client
curl --insecure --user admin:admin -d username=$USERNAME -d password=$PASSWORD -X PUT http://$ENDPOINT/api/clientauth/$TARGET"test1"/$CLIENT
curl --insecure --user admin:admin -d username=$USERNAME -d password=$PASSWORD -X PUT http://$ENDPOINT/api/clientauth/$TARGET"test2"/$CLIENT

## 7. add to clientlun
curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/clientlun/$TARGET"test1"/$CLIENT
curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/clientlun/$TARGET"test2"/$CLIENT
#ceph osd blacklist ls
#ceph osd blacklist clear
