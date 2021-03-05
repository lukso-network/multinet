#!/bin/bash

echo 'Running prysm validator';
echo $MULTINET_POD_IP;


if [ "$MULTINET_POD_NAME" == "prysm-0" ]; then
  ./prysm.sh validator --beacon-rpc-provider localhost:4000 \
  --interop-num-validators=100 \
  --interop-start-index=0 \
  --force-clear-db \
  --accept-terms-of-use
fi

if [ "$MULTINET_POD_NAME" == "prysm-1" ]; then
  ./prysm.sh validator --beacon-rpc-provider localhost:4000 \
  --interop-num-validators=100 \
  --interop-start-index=100 \
  --force-clear-db \
  --accept-terms-of-use
fi

if [ "$MULTINET_POD_NAME" == "prysm-2" ]; then
  ./prysm.sh validator --beacon-rpc-provider localhost:4000 \
  --interop-num-validators=100 \
  --interop-start-index=200 \
  --force-clear-db \
  --accept-terms-of-use
fi

if [ "$MULTINET_POD_NAME" == "prysm-3" ]; then
  ./prysm.sh validator --beacon-rpc-provider localhost:4000 \
  --interop-num-validators=100 \
  --interop-start-index=300 \
  --force-clear-db \
  --accept-terms-of-use
fi
