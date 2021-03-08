#!/bin/bash

echo 'Running prysm validator';
echo $MULTINET_POD_IP;

  ./prysm.sh validator accounts import --keys-dir=/root/multinet/repo/data/common/$MULTINET_POD_NAME \
  --wallet-dir=/tmp/wallets \
  --wallet-password-file=/root/multinet/repo/data/common/$MULTINET_POD_NAME/pass.txt \
  --account-password-file=/root/multinet/repo/data/common/$MULTINET_POD_NAME/pass1.txt \
  --accept-terms-of-use &&

  ./prysm.sh validator --beacon-rpc-provider localhost:4000 \
  --force-clear-db \
  --wallet-dir=/tmp/wallets \
  --wallet-password-file=/root/multinet/repo/data/common/$MULTINET_POD_NAME/pass1.txt \
  --accept-terms-of-use

