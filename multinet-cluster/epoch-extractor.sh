#!/bin/bash
apt update &&
yes | apt install wget &&
wget https://storage.googleapis.com/l16-common/epoch-extractor/epoch-extractor_99f19d31196354e7daa69d3586d479b8747603fe -O ./epoch-extractor &&
chmod +x ./epoch-extractor &&

./epoch-extractor --vanguard-rpc-endpoint $MULTINET_POD_IP:4000 --pandora-rpc-endpoint http://"$MULTINET_POD_IP":8545 --genesis-time-start $ETH_2_GENESIS_TIME
