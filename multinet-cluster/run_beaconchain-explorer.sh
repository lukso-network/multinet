#!/bin/bash

apt update;
yes | apt install wget git unzip;

mkdir /explorer;
cd /explorer;
git clone https://github.com/gobitfly/eth2-beaconchain-explorer;
cd eth2-beaconchain-explorer;


wget https://storage.googleapis.com/l16-common/beaconchain-explorer/bin.zip;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/vanguard-config.yml;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/config.yml;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/tables.sql;

psql -f /src/tables.sql -d db -h 127.0.0.1 -U postgres;

rm -rf ./bin;
unzip bin.zip;

chmod +x ./bin/explorer;
./bin/explorer --config config.yml