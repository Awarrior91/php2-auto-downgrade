# seczennode-automate-install
# Ubuntu 16.04.03 LTS
# This is still in testing
# Dont run this as root!
# This script assumes you already added a sudo-user 

This script aims to automate the installation of a Secure Node for ZenCash.
To run a Secure Node, you will need at least 2 Cores(/vCores) and 4GB RAM.

The script will set up a firewall (ufw) for you.

Then it'll install fail2ban and rkhunter.

After that it installs zend from https://github.com/ZenCashOfficial.

Then it installs the Tracker from https://github.com/ZenCashOfficial.

You will need a fully qualified domain name.

Region Codes are:

eu for Europe

na for North America

sea for Southeast Asia


When you got those, run the script like this:

./autoinst.sh -e YOUREMAILADDRESS -f DOMAINNAME -r REGIONCODE

 
 
After setup.js completed, run 'screen -S tracker'. Then 'cd ~/zencash/secnodetracker' and then 'node app.js'.

To exit the screen (always do it this way) use 'CTRL + A + D'.

To check on the tracker, type 'screen -R tracker'.





Donations appreciated :)

znkXFdS6MVZFxiqoytcGi29J75jzwMtKH1B
