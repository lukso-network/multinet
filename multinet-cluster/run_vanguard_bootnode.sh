#!/bin/bash

echo "Running bootnode";

wget https://github.com/lukso-network/vanguard-consensus-engine/releases/download/v0.1.0-beta.1/bootnode-Linux-x86_64;
mv ./bootnode-Linux-x86_64 ./bootnode;
chmod +x ./bootnode;

./bootnode --external-ip=$MULTINET_POD_IP \
  --private=5ad02bf648b850a44829d9b38976b1b01ddd000fc4c6099ff54aebf4ea07b867

