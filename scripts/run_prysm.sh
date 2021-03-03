#!/bin/bash



echo "Running prysm";

sleep 60000;

#set -eu
#
#source vars.sh

#NBC_DATADIR="/root/multinet/repo/deposits/nimbus-0"

#MULTINET_POD_NAME=${MULTINET_POD_NAME:-prysm-0}
#PRY_DATADIR="/root/multinet/repo/deposits/$MULTINET_POD_NAME"

#SRCDIR=${PRYSM_PATH:-"prysm"}

#set -x
#
#cd "$SRCDIR"
#
#rm -rf /tmp/beacon-prysm
#
## Wait nimbus (bootstrap node)
#wait_enr "$NBC_DATADIR/beacon_node.enr"
#
#sleep 2
#
#BOOTNODES_ARG=""
#if [[ -f $TESTNET_DIR/bootstrap_nodes.txt ]]; then
#  BOOTNODES_ARG="--bootstrap-node=$(cat $TESTNET_DIR/bootstrap_nodes.txt | paste -s -d, -)"
#fi

# needs a mock contract or will not like it
# 0x0 did not work

bazel run //tools/genesis-state-gen -- --num-validators=500 \
 --output-ssz=/tmp/genesis.ssz \
 --mainnet-config

sleep 5

bazel run //beacon-chain -- --datadir /tmp/chaindata \
 --force-clear-db \
 --bootstrap-node= \
 --interop-genesis-state /tmp/genesis.ssz \
 --interop-eth1data-votes \
 --min-sync-peers=0 \
 --accept-terms-of-use &

bazel run //validator -- --beacon-rpc-provider localhost:4000 \
 --interop-num-validators=500 \
 --interop-start-index=0 \
 --clear-db \
 --accept-terms-of-use

#WALLET_DIR=$PRY_DATADIR/prysm/wallets
#
#mkdir -p $WALLET_DIR

if [[ ! -f $WALLET_DIR/password.txt ]]; then
  apt install -y pwgen
  pwgen -B 24 -c 1 -y -n > $WALLET_DIR/password.txt
  bazel run //validator -- \
    wallet create \
    --wallet-dir=$WALLET_DIR \
    --keymanager-kind=derived \
    --wallet-password-file=$WALLET_DIR/password.txt \
    --skip-mnemonic-25th-word-check=false
fi

sleep 5

bazel run //validator --define=ssz=$SPEC_VERSION -- \
  --chain-config-file=$TESTNET_DIR/config.yaml \
  --disable-accounts-v2=true \
  --verbosity=debug \
  --accept-terms-of-use \
  --wallet-dir=$WALLET_DIR

while true
do
	echo ""
	sleep 1
done
