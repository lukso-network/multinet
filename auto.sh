#!/bin/bash
# Just to be sure we're on the right namespace.
echo $NAMESPACE;
# Current time plus 3 minutes to give cluster time to upgrade.
GENESIS_START=$(echo "$(date +%s)"+180 | bc) &&
./genesis-state-gen --output-ssz=/tmp/genesis.ssz \
--output-json=/tmp/genesisL2.json \
--mainnet-config \
--num-validators=2000 \
--genesis-time="$GENESIS_START" &&
kubectl cp /tmp/genesis.ssz  prysm-0:/root/multinet/repo/data/common/genesis.ssz \
-c pandora -n $NAMESPACE &&
kubectl cp /tmp/genesisL2.json  prysm-0:/root/multinet/repo/data/common/genesisL2.json \
-c pandora -n $NAMESPACE &&

# Replacing values in "values.yaml"
yq eval '.'$REPOSITORY'_GH_TAG = "'$REPOSITORY_TAG'"' multinet-cluster/values.yaml -i
yq eval '.ETH_2_GENESIS_TIME = '"$GENESIS_START" multinet-cluster/values.yaml -i &&
yq eval '.MIN_GENESIS_TIME = '$GENESIS_START chain-config.yaml -i &&
kubectl cp ./chain-config.yaml prysm-0:/root/multinet/repo/data/common/chain-config.yaml -c pandora -n $NAMESPACE &&
helm upgrade -f multinet-cluster/values.yaml eth20 ./multinet-cluster/ --namespace "$NAMESPACE" &&
kubectl delete pods prysm-0 --namespace "$NAMESPACE" &&
echo "Done"
