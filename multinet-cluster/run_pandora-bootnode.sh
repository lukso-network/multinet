#!/bin/bash

echo "Running pandora bootnode";

apt update &&
yes | apt install wget &&
wget https://github.com/lukso-network/pandora-execution-engine/releases/download/"$PANDORA_GH_TAG"/geth -O ./geth &&
wget https://storage.googleapis.com/l16-common/pandora/pandora_private_testnet_genesis.json -O ./genesis.json &&

chmod +x ./geth &&
./geth --datadir /blockchainData/pandora-bootnode/"$ETH_2_GENESIS_TIME" init ./genesis.json &&

./geth --datadir /blockchainData/pandora-bootnode/"$ETH_2_GENESIS_TIME" \
--networkid 4004181 \
--verbosity 6 \
--nat extip:$MULTINET_POD_IP
