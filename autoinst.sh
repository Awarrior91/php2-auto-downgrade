#!/bin/bash
while getopts e:r:f: option
do
 case "${option}"
 in
 e) EMAIL=${OPTARG};;
 r) REGION=${OPTARG};;
 f) FQDN=$OPTARG;;
 esac
done
USER=$USER
sudo apt-get update
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
### testnet config
testnet=1
EOF

echo $FQDN
sudo ~/.acme.sh/acme.sh --issue --standalone -d $FQDN
cat <<EOF >> ~/.zen/zen.conf
tlscertpath=/home/$USER/.acme.sh/$FQDN/$FQDN.cer
tlskeypath=/home/$USER/.acme.sh/$FQDN/$FQDN.key
EOF
sudo cp /home/$USER/.acme.sh/$FQDN/ca.cer /usr/share/ca-certificates/ca.crt
zend
sleep 8
zen-cli z_getnewaddress
sudo apt -y install npm
sudo npm install -g n
sudo n latest
cd ~/zencash
git clone https://github.com/ZencashOfficial/secnodetracker.git
cd secnodetracker
npm install
TADDR=$(zen-cli getnewaddress)
sudo dpkg-reconfigure ca-certificates
zen-cli stop
sleep 5
zend
echo "Copy+Paste for the super lazy (me)!"
echo $EMAIL
echo $TADDR
echo $FQDN
echo $REGION
node setup.js
echo "After setup.js completed, run 'screen -S tracker'. Then 'cd ~/zencash/secnodetracker' and then 'node app.js'"
echo "To exit the screen (always do it this way) use 'CTRL + A + D'."
echo "To check on the tracker, type 'screen -R tracker'.


