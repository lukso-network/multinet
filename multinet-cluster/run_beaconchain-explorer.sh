#!/bin/bash

apt update;
yes | apt install wget;

mkdir /explorer;
cd /explorer;

wget https://storage.googleapis.com/l16-common/beaconchain-explorer/explorer;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/vanguard-config.yml;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/config.yml;

chmod +x explorer;
./explorer --config config.yml
