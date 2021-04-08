#!/bin/bash

echo "Generating genesis.ssz..."
rm -f ./vanguard/genesis.ssz

./bin/genesis-state-gen \
	--output-json=./vanguard/genesis.json \
	--output-ssz=./vanguard/genesis.ssz \
	--num-validators=2000 \
	--genesis-time=1617885800 \
	--mainnet-config