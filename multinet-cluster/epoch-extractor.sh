#!/bin/bash
apt update &&
yes | apt install wget &&
wget https://storage.googleapis.com/l16-common/orchestrator/orchestrator_30877bc3d281044cdfe2bfe8d79f3c01b3b10320 -O ./epoch-extractor &&
chmod +x ./epoch-extractor &&

./epoch-extractor --vanguard-rpc-endpoint $MULTINET_POD_IP:4000 --pandora-rpc-endpoint http://"$MULTINET_POD_IP":8545 --genesis-time 1618224331 --verbosity=debug
