#!/bin/bash

echo "Running prysm beacon-node";

mkdir /root/multinet/repo/data/common;

if [ "$MULTINET_POD_NAME" == "prysm-0" ]; then
  EXTERNAL_IP=34.90.144.142;
fi

#if [ "$MULTINET_POD_NAME" == "prysm-1" ]; then
#  EXTERNAL_IP=;
#fi
#
#if [ "$MULTINET_POD_NAME" == "prysm-2" ]; then
#  EXTERNAL_IP=;
#fi
#
#if [ "$MULTINET_POD_NAME" == "prysm-3" ]; then
#  EXTERNAL_IP=;
#fi

while  [ ! -f /root/multinet/repo/data/common/genesis.ssz ]; do
  sleep 5;
done
wget https://storage.googleapis.com/l16-common/vanguard/vanguard_fab88e22e27e0458746cc13ef62a82c0a6ead316 -O ./beacon-chain.run &&
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
  --bootstrap-node="enr:-Ku4QOoNjcQp4g7jd8IziJ_pL29CWbC_UDJ7iC7WNOPo26L4VtSS_F8eLcZ3jQIl7YfTkkgJK85bQ4zYFH_maL3XrmEBh2F0dG5ldHOIAAAAAAAAAACEZXRoMpD1pf1CAAAAAP__________gmlkgnY0gmlwhAoAAg-Jc2VjcDI1NmsxoQKWfbT1atCho149MGMvpgBWUymiOv9QyXYhgYEBZvPBW4N1ZHCCD6A" \
  --http-web3provider=http://127.0.0.1:8545 \
  --deposit-contract=0x000000000000000000000000000000000000cafe \
  --contract-deployment-block=0 \
  --rpc-host="0.0.0.0" \
  --monitoring-host="0.0.0.0" \
  --verbosity=debug \
  --min-sync-peers=0 \
  --p2p-max-peers=10 \
  --p2p-host-ip=$EXTERNAL_IP \
  
  
