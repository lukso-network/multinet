#!/bin/bash

echo "Running prysm beacon-node";

mkdir /root/multinet/repo/data/common;

if [ "$MULTINET_POD_NAME" == "prysm-0" ]; then
  EXTERNAL_IP=34.91.111.241;
fi

if [ "$MULTINET_POD_NAME" == "prysm-1" ]; then
  EXTERNAL_IP=34.91.186.254;
fi

if [ "$MULTINET_POD_NAME" == "prysm-2" ]; then
  EXTERNAL_IP=34.90.76.16;
fi

if [ "$MULTINET_POD_NAME" == "prysm-3" ]; then
  EXTERNAL_IP=35.204.181.122;
fi

while  [ ! -f /root/multinet/repo/data/common/genesis.ssz ]; do
  sleep 5;
done

while  [ ! -f /root/multinet/repo/data/common/chain-config.yaml ]; do
  sleep 5;
done

wget https://storage.googleapis.com/l16-common/vanguard/vanguard_6b495ab864f19b39b8c6d12eacf10f24c5a72c79 -O ./beacon-chain.run &&
chmod +x ./beacon-chain.run &&

./beacon-chain.run \
  --accept-terms-of-use \
  --chain-id=4004181 \
  --network-id=4004181 \
  --interop-genesis-state /root/multinet/repo/data/common/genesis.ssz \
  --interop-eth1data-votes \
  --force-clear-db \
  --datadir /tmp/chaindata \
  --chain-config-file=/root/multinet/repo/data/common/chain-config.yaml \
  --bootstrap-node="enr:-Ku4QHDzUrCOlPOZT8l6sZObcAd_6HCk3eR9UV4UqDLGwJjPEXcPjyGfLW465kXeQSE1hHK17Ka_azMJlPxnP6gi2D8Bh2F0dG5ldHOIAAAAAAAAAACEZXRoMpD1pf1CAAAAAP__________gmlkgnY0gmlwhAoACxaJc2VjcDI1NmsxoQKWfbT1atCho149MGMvpgBWUymiOv9QyXYhgYEBZvPBW4N1ZHCCD6A" \
  --http-web3provider=http://127.0.0.1:8545 \
  --deposit-contract=0x000000000000000000000000000000000000cafe \
  --contract-deployment-block=0 \
  --rpc-host="0.0.0.0" \
  --monitoring-host="0.0.0.0" \
  --verbosity=debug \
  --min-sync-peers=0 \
  --p2p-max-peers=10 \
  --p2p-host-ip=$EXTERNAL_IP \


