#!/bin/bash
while getopts e:r:f:t: option
do
 case "${option}"
 in
 t) TNET=${OPTARG};;
 e) EMAIL=${OPTARG};;
 r) REGION=${OPTARG};;
 f) FQDN=$OPTARG;;
 esac
done
USER=$USER
sudo apt-get update
sudo apt-get install ufw
sudo ufw default allow outgoing
sleep 1
sudo ufw default deny incoming
sleep 1
sudo ufw allow ssh/tcp
sleep 1
sudo ufw limit ssh/tcp
sleep 1
sudo ufw allow http/tcp
sleep 1
sudo ufw allow https/tcp
sleep 1
sudo ufw allow 9033/tcp
sleep 1
if [ $TNET -eq 1 ]
 then
sudo ufw allow 19033/tcp
fi
sleep 1
sudo ufw logging on
sleep 1
sudo ufw enable
sleep 1
sudo apt -y install fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
sudo apt -y install rkhunter
sudo apt -y install build-essential pkg-config libc6-dev m4 g++-multilib autoconf libtool ncurses-dev unzip git python zlib1g-dev wget bsdmainutils automake
sudo apt-get install pwgen screen
mkdir ~/zencash
cd ~/zencash
git clone https://github.com/ZencashOfficial/zen.git
cd zen
./zcutil/fetch-params.sh
./zcutil/build.sh -j$(nproc)
sudo cp ~/zencash/zen/src/zend /usr/bin/
sudo cp ~/zencash/zen/src/zen-cli /usr/bin/
zend
sleep 1
sudo apt install socat
cd
git clone https://github.com/Neilpang/acme.sh.git
cd acme.sh
./acme.sh --install
USERNAME=$(pwgen -s 16 1)
PASSWORD=$(pwgen -s 64 1)
cat <<EOF > ~/.zen/zen.conf
rpcuser=$USERNAME
rpcpassword=$PASSWORD
rpcport=18231
rpcallowip=127.0.0.1
server=1
daemon=1
listen=1
txindex=1
logtimestamps=1
EOF
if [ $TNET -eq 1 ]
 then
echo 'testnet=1' >> ~/.zen/zen.conf
fi

echo $FQDN
sudo ~/.acme.sh/acme.sh --issue --standalone -d $FQDN
cat <<EOF >> ~/.zen/zen.conf
tlscertpath=/home/$USER/.acme.sh/$FQDN/$FQDN.cer
tlskeypath=/home/$USER/.acme.sh/$FQDN/$FQDN.key
EOF
sudo cp /home/$USER/.acme.sh/$FQDN/ca.cer /usr/share/ca-certificates/ca.crt
zend
sleep 15

sudo apt -y install npm
sudo npm install -g n
sudo n latest
cd ~/zencash
git clone https://github.com/ZencashOfficial/secnodetracker.git
cd secnodetracker
npm install
sudo dpkg-reconfigure ca-certificates
zen-cli stop
sleep 5
zend
sleep 10
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
echo "Copy+Paste for the super lazy (me)!"
echo $EMAIL
echo $TADDR
echo $FQDN
echo $REGION
cd ~/zencash/secnodetracker/
node setup.js
echo "After you sent run this command 'pm2 start app.js --name securenodetracker"
echo "Then run this 'pm2 startup | grep sudo | sh -'"
echo "Then 'pm2 save'"
echo "To check if everything works fine, run 'pm2 logs securenodetracker'"

