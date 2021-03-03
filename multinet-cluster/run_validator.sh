#!/bin/bash

echo $MULTINET_POD_IP;


  bazel run //validator -- --beacon-rpc-provider localhost:4000 \
  --interop-num-validators=500 \
  --interop-start-index=0 \
  --force-clear-db \
  --accept-terms-of-use
