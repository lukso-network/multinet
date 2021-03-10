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

./prysm.sh beacon-chain --datadir /tmp/chaindata \
  --force-clear-db \
  --interop-genesis-state /root/multinet/repo/data/common/genesis.ssz \
  --chain-config-file=/root/multinet/repo/data/common/chain-config.yaml \
  --monitoring-host=0.0.0.0 \
  --deposit-contract=0x72C524F3b1bCe12FB0eADb1ab91E6Bcd42C611Cc \
  --http-web3provider=https://goerli.infura.io/v3/b21b783d2d854d609418915a13e2df43 \
  --contract-deployment-block=4367358 \
  --chain-id=5 \
  --network-id=5 \
  --verbosity=debug \
  --min-sync-peers=0 \
  --p2p-max-peers=10 \
  --p2p-host-ip=$EXTERNAL_IP \
  --bootstrap-node=enr:-Ku4QFuEmIcEMoNAox0fh1PdJMeYdzruWFI1rNXi0Xk-Bk9pPpetCQSu27X9vUjYj7rS67L6tJaWWgaB-aNx16-0InkBh2F0dG5ldHOIAAAAAAAAAACEZXRoMpD1pf1CAAAAAP__________gmlkgnY0gmlwhAoAAUaJc2VjcDI1NmsxoQKWfbT1atCho149MGMvpgBWUymiOv9QyXYhgYEBZvPBW4N1ZHCCD6A \
  --accept-terms-of-use
