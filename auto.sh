#!/bin/bash
#echo "Not ready! Please do not use" &&
#exit;
echo $NAMESPACE;
GENESIS_START=$(echo "$(date +%s)"+180 | bc) &&
./genesis-state-gen --output-ssz=/tmp/genesis.ssz \
--mainnet-config \
--num-validators=2000 \
--genesis-time="$GENESIS_START" &&
kubectl cp /tmp/genesis.ssz  prysm-0:/root/multinet/repo/data/common/genesis.ssz \
-c vanguard -n $NAMESPACE --dry-run &&

if [ "$VANGUARD" ]; then
  yq eval '.VANGUARD_GH_TAG = '"$VANGUARD" multinet-cluster/values.yaml -i
fi

if [ "$VALIDATOR" ]; then
  yq eval '.VALIDATOR_GH_TAG = '"$VALIDATOR" multinet-cluster/values.yaml -i
fi

if [ "$PANDORA" ]; then
  yq eval '.PANDORA_GH_TAG = '"$PANDORA" multinet-cluster/values.yaml -i
fi

if [ "$ORCHESTRATOR" ]; then
  yq eval '.ORCHESTRATOR_GH_TAG = '"$ORCHESTRATOR" multinet-cluster/values.yaml -i
fi

yq eval '.ETH_2_GENESIS_TIME = '"$GENESIS_START" multinet-cluster/values.yaml -i &&
yq eval '.ETH_2_GENESIS_TIME = '"$GENESIS_START" multinet-cluster/values.yaml -i &&
yq eval '.MIN_GENESIS_TIME = '$GENESIS_START chain-config.yaml -i &&
kubectl cp ./chain-config.yaml prysm-0:/root/multinet/repo/data/common/chain-config.yaml -c vanguard -n $NAMESPACE --dry-run &&
helm upgrade -f multinet-cluster/values.yaml eth20 ./multinet-cluster/ --namespace "$NAMESPACE" --dry-run &&
kubectl delete pods prysm-0 prysm-1 prysm-2 prysm-3 --namespace "$NAMESPACE" --dry-run &&
echo "$GENESIS_START"
#kubectl get pods -n "$NAMESPACE" -w
