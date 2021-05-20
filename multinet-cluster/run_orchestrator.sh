#!/bin/bash
apt update &&
yes | apt install wget bc &&
wget https://github.com/lukso-network/lukso-orchestrator/releases/download/v"$ORCHESTRATOR_GH_TAG"/lukso-orchestrator_"$ORCHESTRATOR_GH_TAG"_Linux_x86_64 -O ./orchestrator &&
chmod +x ./orchestrator &&

./orchestrator --force-clear-db \
--vanguard-grpc-endpoint=127.0.0.1:4000 \
--ws \
--ws.addr=127.0.0.1 \
--ws.port=7878 \
--pandora-rpc-endpoint=ws://127.0.0.1:8546 \
--verbosity=debug
