#!/bin/bash
echo "Not ready! Please do not use" &&
exit;
#YAML_CONTENT=$(cat ./multinet-cluster/values.yaml) &&
#
#PANDORA_COMMIT=$(echo "$YAML_CONTENT" | shyaml get-value PANDORA_COMMIT) &&
#VANGUARD_COMMIT=$(echo "$YAML_CONTENT" | shyaml get-value VANGUARD_COMMIT) &&
#VALIDATOR_COMMIT=$(echo "$YAML_CONTENT" | shyaml get-value VALIDATOR_COMMIT) &&
#ORCHESTRATOR_COMMIT=$(echo "$YAML_CONTENT" | shyaml get-value VALIDATOR_COMMIT) &&
#
#
##build pandora
#gsutil cp ./pandora gs://l16-common/pandora/pandora_"$PANDORA_COMMIT" &&
#gsutil acl ch -u AllUsers:R gs://l16-common/pandora/pandora_"$PANDORA_COMMIT" &&
#
##build vanguard
#gsutil cp ./validator gs://l16-common/pandora/pandora_"$PANDORA_COMMIT" &&
#gsutil acl ch -u AllUsers:R gs://l16-common/pandora/pandora_"$PANDORA_COMMIT" &&
#
##build validator
#
#gsutil cp ./pandora gs://l16-common/pandora/pandora_"$PANDORA_COMMIT" &&
#gsutil acl ch -u AllUsers:R gs://l16-common/pandora/pandora_"$PANDORA_COMMIT" &&
#
##build orchestrator
#
## NOW + 6 minutes
#GENESIS_START=$(echo "$(date +%s)"+360 | bc) &&
#bazel run //tools/genesis-state-gen -- --output-ssz=/tmp/genesis.ssz \
#--mainnet-config \
#--num-validators=2000 \
#--genesis-time="$GENESIS_START" &&
#kubectl cp /tmp/genesis.ssz  prysm-0:/root/multinet/repo/data/common/genesis.ssz \
#-c vanguard &&
#echo "$GENESIS_START" &&
#helm upgrade -f multinet-cluster/values.yaml eth20 ./multinet-cluster/ &&
#kubectl delete pods prysm-0 prysm-1 prysm-2 prysm-3
#
