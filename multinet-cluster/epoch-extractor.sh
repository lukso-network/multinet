#!/bin/bash
apt update &&
yes | apt install wget bc &&
wget https://github.com/lukso-network/lukso-orchestrator/releases/download/"$ORCHESTRATOR_GH_TAG"/orchestrator -O ./orchestrator &&
chmod +x ./orchestrator &&

./orchestrator --vanguard-rpc-endpoint $MULTINET_POD_IP:4000 --pandora-rpc-endpoint http://"$MULTINET_POD_IP":8545 --genesis-time "$(echo $ETH_2_GENESIS_TIME-6 | bc)" --verbosity=debug
