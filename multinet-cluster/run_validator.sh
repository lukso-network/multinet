#!/bin/bash

echo 'Running prysm validator';
echo $MULTINET_POD_IP;
rm -rf /tmp/wallets;
wget https://storage.googleapis.com/l16-common/validator/validator -O ./validator.run &&
chmod +x ./validator.run &&

  ./validator.run accounts import --keys-dir=/root/multinet/repo/data/common/$MULTINET_POD_NAME \
  --wallet-dir=/tmp/wallets \
  --wallet-password-file=/root/multinet/repo/data/common/$MULTINET_POD_NAME/pass.txt \
  --account-password-file=/root/multinet/repo/data/common/$MULTINET_POD_NAME/pass1.txt \
  --accept-terms-of-use &&

  ./validator.run --beacon-rpc-provider localhost:4000 \
  --pandora-http-provider=http://127.0.0.1:8545 \
  --force-clear-db \
  --wallet-dir=/tmp/wallets \
  --wallet-password-file=/root/multinet/repo/data/common/$MULTINET_POD_NAME/pass.txt \
  --accept-terms-of-use

