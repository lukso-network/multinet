#!/bin/bash

echo 'Running validator client';
echo $MULTINET_POD_IP;
wget https://storage.googleapis.com/l16-common/validator/validator -O ./validator.run &&
chmod +x ./validator.run &&

./validator.run \
  --accept-terms-of-use \
  --beacon-rpc-provider localhost:4000 \
  --interop-num-validators=2000 \
  --force-clear-db \
  --verbosity=debug \
  --pandora-http-provider=http://127.0.0.1:8545 \
  

