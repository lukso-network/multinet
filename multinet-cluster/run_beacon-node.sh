#!/bin/bash

echo "Running prysm (2)";

mkdir /root/multinet/repo/data/common;

if [ "$MULTINET_POD_NAME" == "prysm-0" ]; then
  rm /root/multinet/repo/data/common/genesis.ssz
  bazel run //tools/genesis-state-gen -- --num-validators=500 \
  --output-ssz=/root/multinet/repo/data/common/genesis.ssz \
  --mainnet-config
fi


while  [ ! -f /root/multinet/repo/data/common/genesis.ssz ]; do
  sleep 5;
done

if [ "$MULTINET_POD_NAME" == "prysm-0" ]; then
  ./prysm.sh beacon-chain --datadir /tmp/chaindata \
  --force-clear-db \
  --interop-genesis-state /root/multinet/repo/data/common/genesis.ssz \
  --interop-eth1data-votes \
  --min-sync-peers=0 \
  --verbosity=debug \
  --bootstrap-node=enr:-Ku4QFuEmIcEMoNAox0fh1PdJMeYdzruWFI1rNXi0Xk-Bk9pPpetCQSu27X9vUjYj7rS67L6tJaWWgaB-aNx16-0InkBh2F0dG5ldHOIAAAAAAAAAACEZXRoMpD1pf1CAAAAAP__________gmlkgnY0gmlwhAoAAUaJc2VjcDI1NmsxoQKWfbT1atCho149MGMvpgBWUymiOv9QyXYhgYEBZvPBW4N1ZHCCD6A \
  --accept-terms-of-use
fi

if [ "$MULTINET_POD_NAME" != "prysm-0" ]; then
  ./prysm.sh beacon-chain --datadir /tmp/chaindata \
  --force-clear-db \
  --interop-genesis-state /root/multinet/repo/data/common/genesis.ssz \
  --interop-eth1data-votes \
  --verbosity=debug \
  --bootstrap-node=enr:-Ku4QFuEmIcEMoNAox0fh1PdJMeYdzruWFI1rNXi0Xk-Bk9pPpetCQSu27X9vUjYj7rS67L6tJaWWgaB-aNx16-0InkBh2F0dG5ldHOIAAAAAAAAAACEZXRoMpD1pf1CAAAAAP__________gmlkgnY0gmlwhAoAAUaJc2VjcDI1NmsxoQKWfbT1atCho149MGMvpgBWUymiOv9QyXYhgYEBZvPBW4N1ZHCCD6A \
  --accept-terms-of-use
fi




