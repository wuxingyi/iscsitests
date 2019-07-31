systemctl stop rbd-target-api
systemctl stop tcmu-runner
targetctl clear
for i in `rbd ls`; do rbd rm $i; done
rados rm -p rbd gateway.conf
systemctl reset-failed rbd-target-api.service
systemctl start tcmu-runner
#systemctl start rbd-target-api
