#!/bin/bash
apt update &&
yes | apt install wget bc &&
wget https://github.com/lukso-network/lukso-orchestrator/releases/download/v"$ORCHESTRATOR_GH_TAG"/lukso-orchestrator_"$ORCHESTRATOR_GH_TAG"_Linux_x86_64 -O ./orchestrator &&
chmod +x ./orchestrator &&

./orchestrator --vanguard-rpc-endpoint $MULTINET_POD_IP:4000 --pandora-rpc-endpoint http://"$MULTINET_POD_IP":8545 --genesis-time "$(echo $ETH_2_GENESIS_TIME-6 | bc)" --ws --ws.addr=0.0.0.0 --ws.port=8556 --verbosity=debug
