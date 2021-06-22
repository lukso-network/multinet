#!/bin/bash
apt update &&
yes | apt install wget bc &&
wget https://github.com/lukso-network/lukso-orchestrator/releases/download/"$ORCHESTRATOR_GH_TAG"/lukso-orchestrator_"$ORCHESTRATOR_GH_TAG"_Linux_x86_64 -O ./orchestrator &&
chmod +x ./orchestrator &&

./orchestrator --force-clear-db \
--vanguard-grpc-endpoint=127.0.0.1:4000 \
--http \
--http.addr=0.0.0.0 \
--http.port=7877 \
--ws \
--ws.addr=0.0.0.0 \
--ws.port=7878 \
--pandora-rpc-endpoint=ws://127.0.0.1:8546 \
--verbosity=trace
