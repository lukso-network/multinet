#!/bin/bash

if [ "$MULTINET_POD_NAME" == "prysm-4" ]; then
  sleep infinity;
fi

if [ "$MULTINET_POD_NAME" == "prysm-0" ]; then
  INDEX=0;
fi

if [ "$MULTINET_POD_NAME" == "prysm-1" ]; then
  INDEX=500;
fi

if [ "$MULTINET_POD_NAME" == "prysm-2" ]; then
  INDEX=1000;
fi

if [ "$MULTINET_POD_NAME" == "prysm-3" ]; then
  INDEX=1500;
fi

echo 'Running validator client';
echo $MULTINET_POD_IP;
wget https://github.com/lukso-network/vanguard-consensus-engine/releases/download/"$VANGUARD_GH_TAG"/validator -O ./validator.run &&

echo "Waiting for chain-config.yaml";
while  [ ! -f /root/multinet/repo/data/common/chain-config.yaml ]; do
  sleep 5;
done

chmod +x ./validator.run &&

./validator.run \
  --accept-terms-of-use \
  --beacon-rpc-provider localhost:4000 \
  --chain-config-file=/root/multinet/repo/data/common/chain-config.yaml \
  --interop-num-validators=500 \
  --interop-start-index="$INDEX" \
  --force-clear-db \
  --verbosity=debug \
  --pandora-http-provider=http://127.0.0.1:8545 \
  --lukso-network
