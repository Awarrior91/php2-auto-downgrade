#!/bin/bash

sudo npm install pm2 -g
sudo apt install monit
sed 's/$USER/'"$USER"'/' < ~/php2-auto-downgrade/Znode.sh > ~/zen_node.sh
sudo chmod u+x ~/zen_node.sh
sudo chown $USER:$USER /etc/monit/monitrc
sudo cat <<EOF >> /etc/monit/monitrc
### added on setup for zend
set httpd port 2812
use address localhost # only accept connection from localhost
allow localhost # allow localhost to connect to the server
#
### zend process control
check process zend with pidfile /home/$USER/.zen/zen_node.pid
start program = "/home/$USER/zen_node.sh start" with timeout 60 seconds
stop program = "/home/$USER/zen_node.sh stop"
EOF
sudo chown root:root /etc/monit/monitrc
sudo monit reload
sudo monit start zend
cd ~/zencash/secnodetracker/
pm2 start ~/zencash/secnodetracker/app.js --name securenodetracker
pm2 startup | grep sudo | sh -
pm2 save
echo "To check if everything works fine, run 'pm2 logs securenodetracker'"
