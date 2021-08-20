#!/bin/bash
apt update;
yes | apt install wget git unzip postgresql-client-common postgresql-client-12;

mkdir /explorer;
cd /explorer;
git clone https://github.com/gobitfly/eth2-beaconchain-explorer;
cp ./config1.yml ./eth2-beaconchain-explorer;
cd eth2-beaconchain-explorer;
git checkout c9ef8e810ffb04ad69142421d23a93a17e32cf44;


wget https://storage.googleapis.com/l16-common/beaconchain-explorer/bin.zip;
wget https://storage.googleapis.com/l16-common/beaconchain-explorer/vanguard-config.yml;
#wget https://storage.googleapis.com/l16-common/beaconchain-explorer/config1.yml;
#wget https://storage.googleapis.com/l16-common/beaconchain-explorer/tables.sql;

rm -rf ./bin;
unzip bin.zip;

psql -f ./tables.sql -d db -h 127.0.0.1 -U postgres;

chmod +x ./bin/explorer;
./bin/explorer --config config1.yml
