#!/bin/bash
apt update;
yes | apt install wget git unzip postgresql-client-common postgresql-client-12;

mkdir /explorer;
cd /explorer;
git clone https://github.com/atif-konasl/eth2-beaconchain-explorer;
cp ./config1.yml ./eth2-beaconchain-explorer;
cd eth2-beaconchain-explorer;
git checkout feature/vanguard-pandora-shard-info-view;


wget https://storage.googleapis.com/l16-common/beaconchain-explorer/bin2.zip -O bin.zip;
wget https://storage.googleapis.com/l16-common/vanguard/vanguard-config_808081.yml -O vanguard-config.yml;

rm -rf ./bin;
unzip bin.zip;

EXITCODE=5
while [ $EXITCODE -ne 0 ]
do
  pg_isready -d db -h 127.0.0.1 -U postgres;
  EXITCODE=$?
  echo "not connected retrying...";
  sleep 5;
done

psql -f ./tables.sql -d db -h 127.0.0.1 -U postgres;

chmod +x ./bin/explorer;
./bin/explorer --config config1.yml
