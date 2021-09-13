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
  "808081" \
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
  enr:-J24QKvZGPg1gq3Ud3N_RAHIPL_3PrxIpnC-QcFsfa2PGbxiOR3lb9PhaJga3yBlv2cyB_JeLkz_D_cFOGaUfK0DbXIBg2V0aMfGhL3iEdaAgmlkgnY0gmlwhCJZv3CJc2VjcDI1NmsxoQMYR00cfC59wUqFL2XDEvE2qGSVICa7sWHTE2Z6L18A8oRzbmFwwIN0Y3CCdsWDdWRwgnbF,enr:-J24QAk93dxN6_pB5xZ1WYyRq4CNkeUPeHRSy_7MVinhz0ESEJqF7Gpw9u50fe95hFyGTw8Hym-oO-flWPQKOA18g1MDg2V0aMfGhL3iEdaAgmlkgnY0gmlwhCKNC9SJc2VjcDI1NmsxoQKhsXuAFs5Pdpp3CA0VmXZsx2nVBOHMlVxPg2c_9en4h4RzbmFwwIN0Y3CCdsWDdWRwgnbF,enr:-J24QPHWJAQjY1ji0gLnGSMeH5j1zBhZ6yW9ywkIpCCPIQ0JboroehWZTw6T5alzHSxgTlIqftl2_8E_bvzRJd6MWYACg2V0aMfGhL3iEdaAgmlkgnY0gmlwhCKNGfmJc2VjcDI1NmsxoQM3BHSZo8t6MpXxL5noeSg48GQ-nwL_ARj7iigNWy7ix4RzbmFwwIN0Y3CCdsWDdWRwgnbF,enr:-J24QMSVLOxu7YUpdl4HxvVjNiTkRIKQTZciAKYaknf13j1pXvfVzWboFFC0ATmNSXpsjrLmnZpvoEjtZYSnCrt0OMIBg2V0aMfGhL3iEdaAgmlkgnY0gmlwhCKNaIKJc2VjcDI1NmsxoQOOiq7DRTbLeFfLYuHwiX69DI1wapcMvBLtxZKvsFcFeIRzbmFwwIN0Y3CCdsWDdWRwgnbF \
  --pandora.notify \
  ws://34.141.11.212:7878,ws://34.141.11.212:7878 \
  --ethport \
  "30506" \
  --loglevel \
  "5"
