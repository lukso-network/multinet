#!/bin/bash

echo "Running bootnode";

bazel run //tools/bootnode -- --external-ip=35.204.136.85 \
  --private=5ad02bf648b850a44829d9b38976b1b01ddd000fc4c6099ff54aebf4ea07b867
