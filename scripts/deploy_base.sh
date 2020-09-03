#!/bin/bash
cp *.sh /root
echo "forking to configure-dde-azs.sh, monitor install.log for root or AVIGUI"
su root -c "nohup /root/configure-ddve-azs.sh >/dev/null 2>&1 &"