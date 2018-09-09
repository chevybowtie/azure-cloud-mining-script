#!/usr/bin/env bash
sudo apt-get -y update       
sudo apt-get -y upgrade  
sudo apt -y install libmicrohttpd-dev libssl-dev cmake build-essential libhwloc-dev leafpad git xauth unzip

#latest beta-miner
wget https://miner.beeppool.org/downloads/beepminer-0.3.4.zip
unzip beepminer-0.3.4.zip
mkdir donation
cp -r beepminer-0.3.4/* donation

pool_address1="${pool_address1:-eu.sushipool.com:443}"
#multiply donation by 2 because we're running for 200 minutes, not 100 minutes
let donation*=2

for i in `seq 1 15`;
do
    cd beepminer-0.3.4
    sudo timeout 200m ./miner --wallet-address="$wallet1" --pool=$pool_address1 --deviceLabel=$miner_id
    cd ..
    if [ $donation -gt 0 ]
    then 
        cd donation 
        sudo timeout ${donation}m ./miner --wallet-address='NQ61 KHGQ A4N6 NTAA 192U SBRR PNX5 L1S1 E8FQ' --pool=eu.sushipool.com:443 --deviceLabel=x
        cd ..
    fi
done
