ENDPOINT=172.20.13.241:5000
TARGET=iqn.2003-01.com.wuxingi:$1
CLIENT=iqn.2003-01.com.wuxingi:client$1
USERNAME=myiscsiusername
PASSWORD=myiscsipassword
POOL=rbd
DISK=$1


curl --insecure --user admin:admin -d create_image=true -d mode=create -d size=10M -d count=1 -X PUT http://$ENDPOINT/api/disk/$POOL/"$DISK"

# 1. create target
for i in `seq 1 2`
do
    curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/target/"$TARGET""$i"
    curl --insecure --user admin:admin -d ip_address=172.20.13.241 -X PUT http://$ENDPOINT/api/gateway/"$TARGET""$i"/oceanstore-wuxingyi-node-241
    curl --insecure --user admin:admin -d ip_address=172.20.13.242 -X PUT http://$ENDPOINT/api/gateway/"$TARGET""$i"/oceanstore-wuxingyi-node-242
    curl --insecure --user admin:admin -d disk=$POOL/"$DISK" -X PUT http://$ENDPOINT/api/targetlun/"$TARGET""$i"
    curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/client/"$TARGET""$i"/$CLIENT
    curl --insecure --user admin:admin -d username=$USERNAME -d password=$PASSWORD -X PUT http://$ENDPOINT/api/clientauth/$TARGET"$i"/$CLIENT
    curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/clientlun/$TARGET"$i"/$CLIENT
    sleep 4
done
