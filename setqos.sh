ENDPOINT=172.20.13.241:5000
POOL=rbd
DISK=$3

curl --insecure --user admin:admin -d conf_rbd_qos_bps_limit=$2 -d conf_rbd_qos_write_bps_limit=$2 -d conf_rbd_qos_read_bps_limit=$2 -d conf_rbd_qos_iops_limit=$1 -d conf_rbd_qos_read_iops_limit=$1 -d conf_rbd_qos_write_iops_limit=$1 -X PUT http://$ENDPOINT/api/disk/qos/$POOL/$DISK
