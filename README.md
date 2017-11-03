# seczennode-automate-install

This script aims to automate the installation of a Secure Node for ZenCash.
To run a Secure Node, you will need at least 2 Cores(/vCores) and 4GB RAM.

Before you run the script, you're going to need the current block height, which can be found at 
Testnet:
https://explorer-testnet.zen-solutions.io/
Mainnet:
https://explorer.zensystem.io/

You also need a fully qualified domain name.

Region Codes are:
eu for Europe
na for North America
sea for Southeast Asia

When you got those, run the script as follows:
./autoinst.sh -e YOUREMAILADDRESS -f DOMAINNAME -r REGIONCODE -b BLOCKHEIGHT

This is still in testing
