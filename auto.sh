#!/bin/bash

echo $NAMESPACE;
kubectl cp ./vanguard_private_testnet_genesis.ssz prysm-0:/root/multinet/repo/data/common/genesis.ssz \
-c pandora -n $NAMESPACE &&
kubectl cp ./chain-config.yaml prysm-0:/root/multinet/repo/data/common/chain-config.yaml -c pandora -n $NAMESPACE &&
helm upgrade -f multinet-cluster/values.yaml eth20 ./multinet-cluster/ --namespace "$NAMESPACE" &&
kubectl delete pods prysm-0 prysm-1 prysm-2 prysm-3 --namespace "$NAMESPACE" &&
echo "$GENESIS_START"
