#!/bin/bash

echo $NAMESPACE;
GENESIS_START=$(echo "$(date +%s)"+600 | bc) &&
./genesis-state-gen --output-ssz=./vanguard_private_testnet_genesis.ssz \
--mainnet-config \
--deposit-json-file=./deposit_data.json \
--genesis-time="$GENESIS_START" &&
yq eval '.ETH_2_GENESIS_TIME = '"$GENESIS_START" multinet-cluster/values.yaml -i &&
yq eval '.MIN_GENESIS_TIME = '"$GENESIS_START" chain-config.yaml -i &&
jq --argjson a "${GENESIS_START}" '.config.pandora.consensusInfo[0].epochTimeStart = $a' pandora_private_testnet_genesis.json > "tmp" && mv "tmp" pandora_private_testnet_genesis.json
echo "$GENESIS_START"
