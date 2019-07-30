ENDPOINT=172.20.13.241:5000
TARGET=iqn.2003-01.com.wuxingi:test
CLIENT=iqn.2003-01.com.wuxingi:client$1
USERNAME=myiscsiusername
PASSWORD=myiscsipassword
POOL=rbd
DISK=dididi


for i in `seq 4000 5000`
do
    echo $i
    # 1. create client
    curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/client/$TARGET/"$CLIENT""$i"
    # 2. set chap auth for client
    curl --insecure --user admin:admin -d username=$USERNAME -d password=$PASSWORD -X PUT http://$ENDPOINT/api/clientauth/$TARGET/"$CLIENT""$i"

    curl --insecure --user admin:admin -d disk=$POOL/$DISK -X PUT http://$ENDPOINT/api/clientlun/$TARGET/$CLIENT"$i"
done
