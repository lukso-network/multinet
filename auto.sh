#!/bin/bash

echo $NAMESPACE;
GENESIS_START=$(echo "$(date +%s)"+150 | bc) &&
./genesis-state-gen --output-ssz=/tmp/genesis.ssz \
--mainnet-config \
--deposit-json-file=./deposit_data.json \
--genesis-time="$GENESIS_START" &&
kubectl cp /tmp/genesis.ssz  prysm-0:/root/multinet/repo/data/common/genesis.ssz \
-c vanguard -n $NAMESPACE &&
yq eval '.ETH_2_GENESIS_TIME = '"$GENESIS_START" multinet-cluster/values.yaml -i &&
yq eval '.MIN_GENESIS_TIME = '$GENESIS_START chain-config.yaml -i &&
kubectl cp ./chain-config.yaml prysm-0:/root/multinet/repo/data/common/chain-config.yaml -c vanguard -n $NAMESPACE &&
helm upgrade -f multinet-cluster/values.yaml eth20 ./multinet-cluster/ --namespace "$NAMESPACE" &&
kubectl delete pods prysm-0 --namespace "$NAMESPACE" &&
echo "$GENESIS_START"
