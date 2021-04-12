#!/bin/bash
apt update &&
yes | apt install wget bc &&
wget https://storage.googleapis.com/l16-common/orchestrator/orchestrator_"$ORCHESTRATOR_COMMIT" -O ./epoch-extractor &&
chmod +x ./epoch-extractor &&

./epoch-extractor --vanguard-rpc-endpoint $MULTINET_POD_IP:4000 --pandora-rpc-endpoint http://"$MULTINET_POD_IP":8545 --genesis-time "$(echo $ETH_2_GENESIS_TIME-6 | bc)" --verbosity=debug
