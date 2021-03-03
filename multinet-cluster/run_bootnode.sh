#!/bin/bash

echo "Running bootnode";

mkdir /root/multinet/repo/data/common;

bazel run //tools/bootnode -- --external-ip=$MULTINET_POD_IP \
  --private=5ad02bf648b850a44829d9b38976b1b01ddd000fc4c6099ff54aebf4ea07b867

