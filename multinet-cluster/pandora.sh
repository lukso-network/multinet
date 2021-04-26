#!/bin/bash
apt update &&
yes | apt install wget &&
wget https://github.com/lukso-network/pandora-execution-engine/releases/download/p-v0.0.6-kappa/geth -O ./geth &&
wget https://storage.googleapis.com/l16-common/pandora/pandora_genesis3.json -O ./genesis.json &&

chmod +x ./geth &&
./geth --datadir ./pandora init ./genesis.json &&
# There is no way in kubernetes to get index of a pod so we retrieve it from $MULTINET_POD_NAME
./geth --datadir ./pandora --ethstats test-pandora-"${MULTINET_POD_NAME: -1}":VIyf7EjWlR49@catalyst.silesiacoin.com --bootnodes enode://967db4f56ad0a1a35e3d30632fa600565329a23aff50c9762181810166f3c15b078cca522f930d1a2747778893232336bffd1ea5d2ca60543f1801d4360ea63a@10.0.6.4:0?discport=30301 --networkid 4004181 --rpcaddr 0.0.0.0 --rpcapi admin,eth,net --rpc --rpccorsdomain "*" --miner.etherbase 0xb46d14ef42ac9bb01303ba1842ea784e2460c7e7 --mine --miner.notify ws://localhost:8556 --verbosity 4
