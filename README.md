# Tested on Ubuntu 16.04.03 LTS
# This is still in testing
# Dont run this as root!
# This script assumes you already added a sudo-user 

This script aims to automate the installation of a Secure Node for ZenCash.


The script will set up a firewall (ufw) for you.

Then it'll install fail2ban and rkhunter.

After that it installs zend from https://github.com/ZenCashOfficial/zen

Then it installs the Tracker from https://github.com/ZencashOfficial/secnodetracker

# What do I need?

To run a Secure Node, you will need at least 2 Cores(/vCores) and 4GB RAM.

You need a fully qualified domain name.


# The arguments

-t #

For Testnet, add 1 for #, for Mainnet add 0 for #. Nodes currently only working in Testnet

-e YOUREMAILADDRESS

Your E-Mail so that the tracking server can send you alerts about downtimes


-f DOMAINNAME

Your Domain Name


-r REGIONCODE

Region Codes are:

eu for Europe

na for North America

sea for Southeast Asia

# Run me!

When you got those, run the script like this:

./autoinst.sh -e YOUREMAILADDRESS -f DOMAINNAME -r REGIONCODE -t 1






Thank me maybe? :)

znkXFdS6MVZFxiqoytcGi29J75jzwMtKH1B
