#!/bin/bash

apt update;
yes | apt install wget git;

mkdir /explorer;
cd /explorer;
git clone https://github.com/gobitfly/eth2-beaconchain-explorer;
cd eth2-beaconchain-explorer;


wget https://storage.googleapis.com/l16-common/beaconchain-explorer/bin.zip;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/vanguard-config.yml;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/config.yml;

tar -xzvf bin.zip;

chmod +x explorer;
./explorer --config config.yml
