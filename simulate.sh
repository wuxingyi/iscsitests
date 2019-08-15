ENDPOINT=172.20.13.241:5000
TARGET=iqn.8888-08.com.wuxingi
USERNAME=mysiusername
PASSWORD=mysipassword
POOL=rbd
DISK=$1

discoveryauth() {
    curl --insecure --user admin:admin -d username=$USERNAME"2" -d password=$PASSWORD"2" -d mutual_username=myiscsiusername -d mutual_password=myiscsipassword -X PUT http://$ENDPOINT/api/discoveryauth
}

getconfig() {
    curl --insecure --user admin:admin -X GET http://$ENDPOINT/api/config
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

create_user() {
    curl --insecure --user admin:admin  -d client_iqn=$1 -d username=$USERNAME -d password=$PASSWORD -d mutual_username=myiscsiusername2 -d mutual_password=myiscsipassword2 -X PUT http://$ENDPOINT/api/v2/user
}

remove_user() {
    curl --insecure --user admin:admin  -d client_iqn=$1 -X DELETE http://$ENDPOINT/api/v2/user
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

    for i in `seq 1 1`
    do
        diskstring=$diskstring`echo -n "-d disks=rbd/test1_$i"" "`
    done

    for k in `seq 1 1`
    do

        for j in `seq 300 301`
        do
            NEWCLIENT="$TARGET""$clientsuffix"
            time create_client $NEWTARGET  $NEWCLIENT"$j"
            time curl --insecure --user admin:admin $diskstring -X PUT http://$ENDPOINT/api/clientlun/iqn.8888-08.com.wuxingididi1/$NEWCLIENT"$j"
        done
    done
}

addmappedlun() {
    #curl --insecure --user admin:admin -d disks=rbd/$3 -X PUT http://$ENDPOINT/api/v2/clientlun/$1/$2
    #time curl --insecure --user admin:admin -d handleall=true -X PUT http://$ENDPOINT/api/clientlun/iqn.8888-08.com.wuxingididi1/$NEWCLIENT"$j"
    curl --insecure --user admin:admin -d target_iqn=$1 -d client_iqn=$2 -d handleall=true -X PUT http://$ENDPOINT/api/v2/clientlun
}

removemappedlun() {
    #curl --insecure --user admin:admin -d disks=rbd/$3 -X DELETE http://$ENDPOINT/api/v2/clientlun/$1/$2
    time curl --insecure --user admin:admin -d handleall=true -d target_iqn=$1 -d client_iqn=$2 -X DELETE http://$ENDPOINT/api/v2/clientlun
}
create_client() {
    curl --insecure --user admin:admin -d target_iqn=$1 -d client_iqn=$2 -d username=$USERNAME -d password=$PASSWORD -d mutual_username=myiscsiusername2 -d mutual_password=myiscsipassword2 -X PUT http://$ENDPOINT/api/v2/client
}

remove_client() {
    curl --insecure --user admin:admin -d target_iqn=$1 -d client_iqn=$2 -X DELETE http://$ENDPOINT/api/v2/client
}

create_disk() {
    #DISK=$1
    #SIZE="$2"M
    #curl --insecure --user admin:admin -d create_image=true -d mode=create -d size=$2"M" -X PUT http://$ENDPOINT/api/disk/rbd/$1
    curl --insecure -d create_image=true -d pool=rbd -d image=$1 -d mode=create -d size=$2"M" -X PUT http://$ENDPOINT/api/disk
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
    #默认情况下，保留磁盘
    curl --insecure --user admin:admin -X DELETE http://$ENDPOINT/api/disk/rbd/$1
}

remove_disk_without_mercy() {
    #DISK=$1
    curl --insecure --user admin:admin -d preserve_image=false -X DELETE http://$ENDPOINT/api/disk/rbd/$1
}

remove_target() {
    curl --insecure --user admin:admin -d target_iqn=$1 -X DELETE http://$ENDPOINT/api/v2/target
}


create_target() {
    curl --insecure --user admin:admin -d target_iqn=$1 -X PUT http://$ENDPOINT/api/v2/target
}


set_qos() {
    curl --insecure --user admin:admin -d pool=rbd -d image=$3 -d conf_rbd_qos_bps_limit=$2 -d conf_rbd_qos_write_bps_limit=$2 -d conf_rbd_qos_read_bps_limit=$2 -d conf_rbd_qos_iops_limit=$1 -d conf_rbd_qos_read_iops_limit=$1 -d conf_rbd_qos_write_iops_limit=$1 -X PUT http://$ENDPOINT/api/qos
}

get_qos() {
    curl --insecure --user admin:admin -d pool=rbd -d image=$1 -X GET http://$ENDPOINT/api/qos
}

map_lun_to_target() {
    #DISK=$1
    #TARGET=$2
    curl --insecure --user admin:admin -d target_iqn=$2 -d disk=rbd/$1 -X PUT http://$ENDPOINT/api/v2/targetlun
}

get_target_luns() {
    curl --insecure --user admin:admin -d target_iqn=$2 -X GET http://$ENDPOINT/api/v2/targetlun
}

unmap_lun_from_target() {
    #DISK=$1
    #TARGET=$2
    curl --insecure --user admin:admin -d target_iqn=$2 -d disk=rbd/$1 -X DELETE http://$ENDPOINT/api/v2/targetlun
}

s_create_100_targets() {
    for i in `seq 1 100`
    do
        time create_target "$TARGET""googlechrome""$i"
    done
}

s_remove_100_targets() {
    for i in `seq 1 100`
    do
        time remove_target "$TARGET""googlechrome""$i"
    done
}

s_create_1000_disks() {
    for i in `seq 1 10`
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
    #s_create_1000_disks
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

s_test_mapping_10() {
    for i in `seq 1 1`
    do
        TARGET2=$"$TARGET"googlechrome"$i"
        create_target $TARGET2
        create_disk dididi$i 10
        set_qos 100 100 dididi$i
        create_snapshot dididi$i snap1
        create_snapshot dididi$i snap2
        map_lun_to_target dididi$i $TARGET2
    done
}

s_test_unmapping_10() {
    for i in `seq 1 3`
    do
        TARGET2=$"$TARGET"googlechrome"$i"
        unmap_lun_from_target didi$i $TARGET2
        remove_target $TARGET2
    done
}
s_test_mapping() {
    TARGET2=$"$TARGET"didi2
    #remove_target $TARGET2
    create_target $TARGET2
    create_disk test 10
    map_lun_to_target test $TARGET2
}

s_test_unmapping() {
    TARGET2=$"$TARGET"didi
    #remove_target $TARGET2
    create_target $TARGET2
    create_disk test 1024
    map_lun_to_target test $TARGET2
    unmap_lun_from_target test $TARGET2
}

s_qos_simpletest() {
    for i in `seq 1 100`
    do
        create_disk test"$i" 10
        time set_qos $(($i*1112)) 1112 test"$i"
        time get_qos test"$i"
    done
}

s_client_simpletest() {
    TARGET2=$"$TARGET"didi
    CLIENT=$"$TARGET"didiclient
    create_target $TARGET2
    gwcli ls
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
    create_disk test 10
    map_lun_to_target test $TARGET2
    create_user $CLIENT
    create_client $TARGET2  $CLIENT
    addmappedlun $TARGET2  $CLIENT test
}

s_remove_lun_from_client() {
    TARGET2=$"$TARGET"didi
    CLIENT=$"$TARGET"didiclient
    removemappedlun $TARGET2  $CLIENT test
    remove_client $TARGET2  $CLIENT
    remove_user $CLIENT
    unmap_lun_from_target test $TARGET2
    remove_disk test
    remove_target $TARGET2
}

s_add100lunstoclient() {
    TARGET2=$"$TARGET"didi
    CLIENT=$"$TARGET"didiclient
    create_target $TARGET2
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

s_multipletarget_alsomappedlun() {
    TARGETS_NR=4
    LUN_PER_TARGET_NR=1
    CLIENTS_NR=1
    for k in `seq  2 $TARGETS_NR`
    do
        date
        echo "processing the $k target"
        kk=`printf "%04d" $k`

        NEWTARGET="$TARGET"applesafari"$kk"
        time create_target $NEWTARGET
        #curl --insecure --user admin:admin -d action='disable_acl' -X PUT http://$ENDPOINT/api/targetauth/iqn.8888-08.com.wuxingiapplesafari0001


        echo "starting create luns"
        for i in `seq 1 $LUN_PER_TARGET_NR`
        do
            ii=`printf "%04d" $i`
            time create_disk safaritest"$kk"_"$ii" 10
            time map_lun_to_target safaritest"$kk"_"$ii" $NEWTARGET
        done

        # create clients
        for j in `seq 1 $CLIENTS_NR`
        do
            jj=`printf "%04d" $j`
            NEWCLIENT="$TARGET""firefoxclient"
            time create_user $NEWCLIENT"$kk""$jj"
            time create_client $NEWTARGET  $NEWCLIENT"$kk""$jj"
            time addmappedlun $NEWTARGET $NEWCLIENT"$kk""$jj"
        done
    done
}

s_multitarget_mapthem() {
    TARGETS_NR=100
    CLIENTS_NR=4
    for k in `seq 1 $TARGETS_NR`
    do
        date
        NEWTARGET="$TARGET"googlechrome"$k"
        for j in `seq 1 $CLIENTS_NR`
        do
            NEWCLIENT="$TARGET"didiclient
            addmappedlun $NEWTARGET $NEWCLIENT"$j"
        done
    done
}

s_add_4_users_no_mappedlun() {
    TARGETS_NR=100
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

get_snapshot() {
    curl --insecure --user admin:admin -d pool=rbd -d disk=$1 -X GET http://172.20.13.241:5000/api/snapshot
}

create_snapshot() {
    curl --insecure --user admin:admin -d mode=create -d pool=rbd -d image=$1 -d name=$2 -X PUT http://172.20.13.241:5000/api/snapshot
}

remove_snapshot() {
    curl --insecure --user admin:admin -d pool=rbd -d image=$1 -d name=$2 -X DELETE http://172.20.13.241:5000/api/snapshot
}

s_snapshot() {
    create_disk didi66 10
    create_snapshot didi66 testsnap1
    create_snapshot didi66 testsnap2
    #get_snapshot didi66 
    #remove_snapshot didi66 testsnap1
    #remove_snapshot didi66 testsnap2
    get_snapshot didi66 
    #remove_disk didi66
    rbd ls
}

bind_group() {
    curl --insecure --user admin:admin -d groupname=$1 -d target_iqn=$2 -X PUT http://$ENDPOINT/api/v2/usergroup/target
}
unbind_group() {
    curl --insecure --user admin:admin -d groupname=$1 -d target_iqn=$2 -X DELETE http://$ENDPOINT/api/v2/usergroup/target
}

s_group_bind_unbind() {
    curl --insecure --user admin:admin -d groupname=testasdf2 -X PUT http://$ENDPOINT/api/v2/usergroup
    create_target iqn.8888-08.com.wuxingididhahahaha
    create_target iqn.8888-08.com.wuxingididhahahaha2
    bind_group testasdf2 iqn.8888-08.com.wuxingididhahahaha
    bind_group testasdf2 iqn.8888-08.com.wuxingididhahahaha2
    getconfig
    unbind_group testasdf2 iqn.8888-08.com.wuxingididhahahaha
    getconfig
    unbind_group testasdf2 iqn.8888-08.com.wuxingididhahahaha2
    getconfig
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
#user_group
#list_user_groups
#get_user_auth
#create_disk test 100
 #s_test_mapping
#discoveryauth
#s_test_unmapping
#s_test_mapping
#s_remove_all_clients
#s_remove_all_clients_of_target
#s_setqos_1000_disks
#s_snapshot
#list_user_groups
#get_user_auth
#s_remove_lun_from_client
#sleep 1
#s_addluntoclient
#s_group_bind_unbind
#s_group_bind_unbind
#s_test_mapping
#s_create_1000_disks
#s_test_mapping_10
#time s_create_100_targets
#time s_remove_100_targets
#time s_test_mapping_10
#sleep 10
#time s_test_unmapping_10
#s_client_simpletest
#s_singletarget_nomappedlun
#s_multitarget_mapthem
#time s_multipletarget_alsomappedlun
s_qos_simpletest
#s_test_mapping_10
#s_group_bind_unbind
