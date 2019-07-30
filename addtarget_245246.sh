ENDPOINT=172.20.13.241:5000
TARGET=iqn.2003-01.com.wuxingi:$1
CLIENT=iqn.2003-01.com.wuxingi:client$1
USERNAME=myiscsiusername
PASSWORD=myiscsipassword
POOL=rbd
DISK=$1


# 1. create target
curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/target/$TARGET

# 2. create gateways for the target
curl --insecure --user admin:admin -d ip_address=172.20.13.245 -X PUT http://$ENDPOINT/api/gateway/$TARGET/oceanstore-wuxingyi-node-245
curl --insecure --user admin:admin -d ip_address=172.20.13.246 -X PUT http://$ENDPOINT/api/gateway/$TARGET/oceanstore-wuxingyi-node-246

# 3. create a rbd backend disk
curl --insecure --user admin:admin -d create_image=true -d mode=create -d size=10G -d count=1 -X PUT http://$ENDPOINT/api/disk/$POOL/$DISK

# 4. create client
curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/client/$TARGET/$CLIENT

# 5. set chap auth for client
curl --insecure --user admin:admin -d username=$USERNAME -d password=$PASSWORD -X PUT http://$ENDPOINT/api/clientauth/$TARGET/$CLIENT

# 6. add to targetlun
curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/targetlun/$TARGET

# 7. add to clientlun
curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/clientlun/$TARGET/$CLIENT
#ceph osd blacklist ls
#ceph osd blacklist clear
