#!/bin/bash
apt update &&
yes | apt install wget &&
wget https://storage.googleapis.com/l16-common/epoch-extractor/epoch-extractor_fd5851924ec70ecf5e16a4e77dfb0d078e33e0b2 -O ./epoch-extractor &&
chmod +x ./epoch-extractor &&

./epoch-extractor --vanguard-rpc-endpoint $MULTINET_POD_IP:4000 --pandora-rpc-endpoint http://"$MULTINET_POD_IP":8545 --genesis-time-start $ETH_2_GENESIS_TIME
