#!/bin/bash
echo "Not ready! Please do not use" &&
exit;
#
#NAMESPACE="test" &&
#echo $NAMESPACE &&
## Generate genesis
### NOW + 6 minutes
#GENESIS_START=$(echo "$(date +%s)"+360 | bc) &&
#cd ../prysm &&
#bazel run //tools/genesis-state-gen -- --output-ssz=/tmp/genesis.ssz \
#--mainnet-config \
#--num-validators=2000 \
#--genesis-time="$GENESIS_START" &&
#cd ../l16-multinet &&
#ls multinet-cluster/values.yaml &&
#kubectl cp /tmp/genesis.ssz  prysm-0:/root/multinet/repo/data/common/genesis.ssz \
#-c vanguard -n $NAMESPACE &&
#yq eval '.ETH_2_GENESIS_TIME = '"$GENESIS_START" multinet-cluster/values.yaml -i &&
#yq eval '.MIN_GENESIS_TIME = '$GENESIS_START chain-config.yaml -i &&
#kubectl cp ./chain-config.yaml prysm-0:/root/multinet/repo/data/common/chain-config.yaml -n $NAMESPACE
#echo "$GENESIS_START" &&
#helm upgrade -f multinet-cluster/values.yaml eth20 ./multinet-cluster/ --namespace "$NAMESPACE" &&
#kubectl delete pods prysm-0 prysm-1 prysm-2 prysm-3 --namespace "$NAMESPACE"

