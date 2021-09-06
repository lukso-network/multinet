#!/bin/bash

echo "Running pandora faucet";

TWITTER_TOKEN=$(cat /root/l15/twitter.txt)
FAUCET_FULL_LINK=$(cat /root/l15/stats.txt)

faucet \
  --account.json \
  /root/l15/account.json \
  --account.pass \
  /root/l15/password.txt \
  --network \
  "808080" \
  --faucet.amount \
  "32" \
  --faucet.name \
  L15 \
  --genesis \
  /root/l15/pandora-genesis.json \
  --faucet.minutes \
  "45" \
  --twitter.token \
  "$TWITTER_TOKEN" \
  --ethstats \
  "$FAUCET_FULL_LINK" \
  --bootnodes \
  enr:-J24QLvJD-BOCMc7awEMdKXdjjbsJVG6TiFLNJl0-zj4JyCbNqPb9Su5gdhD0JCtjkVQm-NCpUUODLxLfsuQiPQT0mQBg2V0aMfGhL3iEdaAgmlkgnY0gmlwhCPy9s6Jc2VjcDI1NmsxoQJVJ7i9lhJgJv6wzAnIUxXgnrJ2lG-k8HGHaVwv-4sDS4RzbmFwwIN0Y3CCdsWDdWRwgnbF \
  --pandora.notify \
  ws://35.242.246.206:7878,ws://35.242.246.206:7878 \
  --ethport \
  "30506" \
  --loglevel \
  "5"

