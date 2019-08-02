ENDPOINT=172.20.13.241:5000
TARGET=iqn.8888-08.com.wuxingi
USERNAME=mysiusername
PASSWORD=mysipassword
POOL=rbd
DISK=$1

discoveryauth() {
    curl --insecure --user admin:admin -d username=$USERNAME"2" -d password=$PASSWORD"2" -d mutual_username=myiscsiusername -d mutual_password=myiscsipassword -X PUT http://$ENDPOINT/api/discoveryauth
}


apis() {
    curl --insecure --user admin:admin -X GET http://$ENDPOINT/api
}

list_user_groups() {
    curl --insecure --user admin:admin -X GET http://$ENDPOINT/api/v2/usergroups
}

get_user_auth() {
    for i in `seq 1 10`
    do
        curl --insecure --user admin:admin -X GET http://$ENDPOINT/api/v2/user/iqn.8888-08.com.wuxingididhahahaha$i
    done
}

user_group() {
    curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/v2/usergroups/testasdf2
    for i in `seq 11 20`
    do
        #curl --insecure --user admin:admin -d username=$USERNAME"2" -d password=$PASSWORD"2" -d mutual_username=myiscsiusername8 -d mutual_password=myiscsipassword0 -X PUT http://$ENDPOINT/api/v2/user/iqn.8888-08.com.wuxingididhahahaha$i
        curl --insecure --user admin:admin -d username=$USERNAME"$i" -d password=$PASSWORD"$i" -d mutual_username="$USERNAME""$i" -d mutual_password="$PASSWORD""$i" -X PUT http://$ENDPOINT/api/v2/user/iqn.8888-08.com.wuxingididhahahaha$i
    done

    sleep 5
    for i in `seq 1 10`
    do
        curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/v2/usergroup/testasdf2/iqn.8888-08.com.wuxingididhahahaha$i
    done
}


create_usergroups() {
    for i in `seq 1 100`
    do
        curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/v2/usergroups/testasdf$i
    done
}

delete_usergroups() {
    for i in `seq 1 100`
    do
        curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/v2/usergroups/testasdf$i
    done
}

get_users() {
    for i in `seq 1 1`
    do
        curl --insecure --user admin:admin  -X GET http://$ENDPOINT/api/v2/user/iqn.8888-08.com.wuxingididhaha"$i"
    done
}

create_users() {
    for i in `seq 1 100`
    do
        curl --insecure --user admin:admin  -d username=$USERNAME -d password=$PASSWORD -d mutual_username=myiscsiusername2 -d mutual_password=myiscsipassword2 -X PUT http://$ENDPOINT/api/v2/user/iqn.8888-08.com.wuxingididhaha"$i"
    done
}

delete_users() {
    for i in `seq 1 100`
    do
        curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/v2/user/iqn.8888-08.com.wuxingididhaha"$i"
    done
}

s_remove_all_clients_of_target() {
    NEWTARGET="$TARGET""didi"

    for k in `seq 1 16`
    do
        time curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/v2/clients/$NEWTARGET"$k"
    done
}

s_remove_all_clients() {
    NEWTARGET="$TARGET""didi1"
    clientsuffix="test"
    diskstring=""

    for k in `seq 1 1`
    do

        for j in `seq 1 200`
        do
            NEWCLIENT="$TARGET""$clientsuffix"
            time curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/client/$NEWTARGET/$NEWCLIENT"$j"
        done
    done
}

s_remove_all_disks_from_client() {
    NEWTARGET="$TARGET""didi1"
    clientsuffix="test"
    diskstring=""

    for k in `seq 1 1`
    do

        for j in `seq 1 200`
        do
            NEWCLIENT="$TARGET""$clientsuffix"
            time curl --insecure --user admin:admin -d handleall=true -X DELETE http://$ENDPOINT/api/clientlun/iqn.8888-08.com.wuxingididi1/$NEWCLIENT"$j"
        done
    done
}

s_remove_disks_from_client() {
    NEWTARGET="$TARGET""didi1"
    clientsuffix="test"
    diskstring=""

    for i in `seq 1 4`
    do
        diskstring=$diskstring`echo -n "-d disks=rbd/test1_$i"" "`
    done

    for k in `seq 1 1`
    do

        for j in `seq 1 30`
        do
            NEWCLIENT="$TARGET""$clientsuffix"
            time curl --insecure --user admin:admin $diskstring -X DELETE http://$ENDPOINT/api/clientlun/iqn.8888-08.com.wuxingididi1/$NEWCLIENT"$j"
        done
    done
}

s_adddisks_toclient() {
    NEWTARGET="$TARGET""didi1"
    clientsuffix="test"
    diskstring=""

    for i in `seq 1 3`
    do
        diskstring=$diskstring`echo -n "-d disks=rbd/test1_$i"" "`
    done

    for k in `seq 1 1`
    do

        for j in `seq 41 200`
        do
            NEWCLIENT="$TARGET""$clientsuffix"
            time create_client $NEWTARGET  $NEWCLIENT"$j"
            time curl --insecure --user admin:admin -d handleall=true -X PUT http://$ENDPOINT/api/clientlun/iqn.8888-08.com.wuxingididi1/$NEWCLIENT"$j"
        done
    done
}

create_hostgroup() {
    curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/hostgroup/$1/$2
}

add_client_and_disk_to_group() {
    curl --insecure --user admin:admin -d members=iqn.8888-08.com.wuxingididiclient1,iqn.8888-08.com.wuxingididiclient2 -d disks=rbd/test1_1,rbd/test1_2 -X PUT http://$ENDPOINT/api/hostgroup/$1/$2
}

remove_client_and_disk_from_group() {
    curl --insecure --user admin:admin -d action=remove -d members=iqn.8888-08.com.wuxingididiclient2,iqn.8888-08.com.wuxingididiclient3 -d disks=rbd/test1_1 -X PUT http://$ENDPOINT/api/hostgroup/$1/$2
}

addmappedlun() {
    curl --insecure --user admin:admin -d disk=rbd/$3 -X PUT http://$ENDPOINT/api/clientlun/$1/$2
}

create_client() {
    curl --insecure --user admin:admin -d username=$USERNAME -d password=$PASSWORD -d mutual_username=myiscsiusername2 -d mutual_password=myiscsipassword2 -X PUT http://$ENDPOINT/api/client/$1/$2
}

remove_client() {
    curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/client/$1/$2
}

remove_gateway() {
    curl --insecure --user admin:admin -d ip_address=172.20.13.241 -X DELETE http://$ENDPOINT/api/gateway/$1/oceanstore-wuxingyi-node-241
}

create_gateway() {
    curl --insecure --user admin:admin -d ip_address=172.20.13.241 -X PUT http://$ENDPOINT/api/gateway/$1/oceanstore-wuxingyi-node-241
}
create_disk() {
    #DISK=$1
    #SIZE="$2"M
    curl --insecure --user admin:admin -d create_image=true -d mode=create -d size=$2"M" -X PUT http://$ENDPOINT/api/disk/rbd/$1
}

resize_disk() {
    #DISK=$1
    #SIZE="$2"M
    curl --insecure --user admin:admin -d mode=resize -d size=$2"M" -X PUT http://$ENDPOINT/api/disk/rbd/$1
}

get_disk() {
    #DISK=$1
    #SIZE="$2"M
    curl --insecure --user admin:admin -X GET http://$ENDPOINT/api/disk/rbd/$1
}

remove_disk() {
    #DISK=$1
    curl --insecure --user admin:admin -d preserve_image=false -X DELETE http://$ENDPOINT/api/disk/rbd/$1
}

remove_target() {
    curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/target/$1
}


create_target() {
    curl --insecure --user admin:admin -X PUT http://$ENDPOINT/api/target/$1
}


set_qos() {
    curl --insecure --user admin:admin -d conf_rbd_qos_bps_limit=$2 -d conf_rbd_qos_write_bps_limit=$2 -d conf_rbd_qos_read_bps_limit=$2 -d conf_rbd_qos_iops_limit=$1 -d conf_rbd_qos_read_iops_limit=$1 -d conf_rbd_qos_write_iops_limit=$1 -X PUT http://$ENDPOINT/api/disk/qos/rbd/$3
}

get_qos() {
    curl --insecure --user admin:admin  -X GET http://$ENDPOINT/api/disk/qos/rbd/$1
}

map_lun_to_target() {
    #DISK=$1
    #TARGET=$2
    curl --insecure --user admin:admin -d disk=rbd/$1 -X PUT http://$ENDPOINT/api/targetlun/$2
}

get_target_luns() {
    curl --insecure --user admin:admin -X GET http://$ENDPOINT/api/targetlun/$1
}

unmap_lun_from_target() {
    #DISK=$1
    #TARGET=$2
    curl --insecure --user admin:admin -d disk=rbd/$1 -X DELETE http://$ENDPOINT/api/targetlun/$2
}

s_create_100_targets() {
    for i in `seq 1 10`
    do
        time create_target "$TARGET""didi""$i"
    done
}

s_remove_100_targets() {
    for i in `seq 1 10`
    do
        time remove_target "$TARGET""didi""$i"
    done
}

s_create_1000_disks() {
    for i in `seq 1 1000`
    do
        time create_disk didi"$i" 10
    done
}

s_remove_1000_disks() {
    for i in `seq 1 1000`
    do
        time remove_disk didi"$i"
    done
}
s_setqos_1000_disks() {
    for i in `seq 1 1000`
    do
        time set_qos 1000 1000 didi"$i"
    done
}

s_getqos_1000_disks() {
    for i in `seq 1 1000`
    do
        time get_qos didi"$i"
    done
}

s_testqos_and_test_size() {
    time create_disk didi 10
    time set_qos 10 10 didi
    time get_qos didi
    time get_disk didi
    time resize_disk didi 100
    time get_disk didi
    #time remove_disk didi
}

s_test_mapping() {
    TARGET2=$"$TARGET"didi
    remove_gateway $TARGET2
    remove_target $TARGET2
    create_target $TARGET2
    create_gateway $TARGET2
    create_disk test 1024
    map_lun_to_target test $TARGET2
}

s_test_unmapping() {
    TARGET2=$"$TARGET"didi
    #remove_gateway $TARGET2
    #remove_target $TARGET2
    create_target $TARGET2
    create_gateway $TARGET2
    create_disk test 1024
    map_lun_to_target test $TARGET2
    unmap_lun_from_target test $TARGET2
}

s_qos_simpletest() {
    time set_qos 1110 1110 test
    time get_qos test
}

s_client_simpletest() {
    TARGET2=$"$TARGET"didi
    CLIENT=$"$TARGET"didiclient
    create_target $TARGET2
    gwcli ls
    create_gateway $TARGET2
    gwcli ls
    create_client $TARGET2  $CLIENT
    gwcli ls
    remove_client $TARGET2  $CLIENT
    gwcli ls
}



s_addluntoclient() {
    TARGET2=$"$TARGET"didi
    CLIENT=$"$TARGET"didiclient
    create_target $TARGET2
    create_gateway $TARGET2
    create_disk test 1024
    map_lun_to_target test $TARGET2
    create_client $TARGET2  $CLIENT
    addmappedlun $TARGET2  $CLIENT test
}

s_add100lunstoclient() {
    TARGET2=$"$TARGET"didi
    CLIENT=$"$TARGET"didiclient
    create_target $TARGET2
    create_gateway $TARGET2
    create_client $TARGET2  $CLIENT
    for i in `seq 1 100`
    do
        time create_disk test$i 10
        time map_lun_to_target test$i $TARGET2
        time addmappedlun $TARGET2  $CLIENT test"$i"
    done
}

s_add100lunstoclient_sep() {
    TARGET2="$TARGET"didi
    create_target $TARGET2
    create_gateway $TARGET2

    for j  in `seq 1 100`
    do
        NEWCLIENT="$TARGET"didiclient
        create_client $TARGET2  $NEWCLIENT"$j"
        echo "starting create luns"
        for i in `seq 1 5`
        do
            time create_disk test"$j"_$i 10
        done

        echo "starting map luns to target"
        for i in `seq 1 5`
        do
            time map_lun_to_target test"$j"_$i $TARGET2
        done

        echo "starting mapping acls"
        for i in `seq 1 5`
        do
            time addmappedlun $TARGET2  $NEWCLIENT"$j" test"$j"_$i
        done
    done
}

s_aclgroup() {
    TARGET2="$TARGET"didi
    create_target $TARGET2
    create_gateway $TARGET2

    for j  in `seq 1 1`
    do
        echo "starting create luns"
        for i in `seq 1 10`
        do
            time create_disk test"$j"_$i 10
        done

        echo "starting map luns to target"
        for i in `seq 1 10`
        do
            time map_lun_to_target test"$j"_$i $TARGET2
        done
    done

    for j in `seq 1 20`
    do
        NEWCLIENT="$TARGET"didiclient
        create_client $TARGET2  $NEWCLIENT"$j"

        for i in `seq 1 10`
        do
            time addmappedlun $TARGET2  $NEWCLIENT"$j" test1_$i
        done

    done

}

addtwonewusertogroup() {
    for k in `seq 1 10`
    do
        NEWTARGET="$TARGET""didi""$k"

        # create 2 clients
        for j in `seq 1 2`
        do
            NEWCLIENT="$TARGET"didiclientyou"$RANDOM"
            create_client $NEWTARGET  $NEWCLIENT"$j"

            for i in `seq 1 10`
            do
                time addmappedlun $NEWTARGET $NEWCLIENT"$j" test"$k"_$i
            done
        done
    done

}

s_aclgroup_multitarget() {
    TARGETS_NR=1
    LUN_PER_TARGET_NR=128
    CLIENTS_NR=1
    for k in `seq 1 $TARGETS_NR`
    do
        date
        echo "processing the $k target"

        NEWTARGET="$TARGET""didi""$k"
        create_target $NEWTARGET
        create_gateway $NEWTARGET

        NEWTARGET="$TARGET"didi"$k"
        echo "starting create luns"
        for i in `seq 1 $LUN_PER_TARGET_NR`
        do
            create_disk test"$k"_$i 10
            map_lun_to_target test"$k"_$i $NEWTARGET
        done


        NEWTARGET="$TARGET""didi""$k"

        # create 10 clients
        for j in `seq 1 $CLIENTS_NR`
        do
            NEWCLIENT="$TARGET"didiclient
            create_client $NEWTARGET  $NEWCLIENT"$j"

            for i in `seq 1 $LUN_PER_TARGET_NR`
            do
                addmappedlun $NEWTARGET $NEWCLIENT"$j" test"$k"_$i
            done

        done
    done
}

s_singletarget_nomappedlun() {
    TARGETS_NR=16
    LUN_PER_TARGET_NR=1
    CLIENTS_NR=32
    for k in `seq 1 $TARGETS_NR`
    do
        date
        echo "processing the $k target"

        NEWTARGET="$TARGET""didi""$k"
        create_target $NEWTARGET
        create_gateway $NEWTARGET

        NEWTARGET="$TARGET"didi"$k"
        echo "starting create luns"
        for i in `seq 1 $LUN_PER_TARGET_NR`
        do
            create_disk test"$k"_$i 10
            map_lun_to_target test"$k"_$i $NEWTARGET
        done


        NEWTARGET="$TARGET""didi""$k"

        # create 10 clients
        for j in `seq 1 $CLIENTS_NR`
        do
            NEWCLIENT="$TARGET"didiclient
            create_client $NEWTARGET  $NEWCLIENT"$j"
        done
    done
}

s_add_4_users_no_mappedlun() {
    TARGETS_NR=1
    LUN_PER_TARGET_NR=128
    CLIENTS_NR=100
    for k in `seq 1 $TARGETS_NR`
    do
        NEWTARGET="$TARGET""didi""$k"

        # create 2 clients
        for j in `seq 1 $CLIENTS_NR`
        do
            NEWCLIENT="$TARGET"didiclientyou"$RANDOM"
            create_client $NEWTARGET  $NEWCLIENT"$j"
        done
    done
}

s_process_hostgroup() {
    TARGETS_NR=1
    LUN_PER_TARGET_NR=128
    CLIENTS_NR=100
    GROUP_NAME=didi

    for k in `seq 1 $TARGETS_NR`
    do
        NEWTARGET="$TARGET""didi""$k"

        # create 2 clients
        for j in `seq 1 $CLIENTS_NR`
        do
            NEWCLIENT="$TARGET"didiclientyou"$RANDOM"
            create_client $NEWTARGET  $NEWCLIENT"$j"
        done
    done
}

addpureclient() {
    for k in `seq 1 1`
    do
        NEWTARGET="$TARGET""didi""$k"

        # create 2 clients
        for j in `seq 1 100`
        do
            NEWCLIENT="$TARGET"didiclientfuckyou
            create_client $NEWTARGET  $NEWCLIENT"$j"
        done
    done

}
#s_client_simpletest
#time addpureclient
##time s_add_4_users_no_mappedlun
##remove_client_and_disk_from_group iqn.8888-08.com.wuxingididi1 dididi2
#add_client_and_disk_to_group iqn.8888-08.com.wuxingididi1 dididi2
#apis
#time s_singletarget_nomappedlun
#s_adddisks_toclient
#s_remove_disks_from_client
#create_disk didi 10
#get_target_luns "$TARGET""didi1"
#s_adddisks_toclient
#s_remove_all_disks_from_client
#s_remove_all_clients
#s_remove_all_clients_of_target
#create_users
#get_users
#delete_users
#create_usergroups
#delete_usergroups
user_group
#list_user_groups
#get_user_auth
#create_disk test 100
 #s_test_mapping
#discoveryauth
