#!/bin/bash
apt update &&
yes | apt install wget &&
wget https://storage.googleapis.com/l16-common/pandora/geth -O ./geth &&
wget https://storage.googleapis.com/l16-common/pandora/pandora_genesis2.json -O ./genesis.json &&

chmod +x ./geth &&
./geth --datadir ./pandora init ./genesis.json &&
./geth --datadir ./pandora --bootnodes enode://967db4f56ad0a1a35e3d30632fa600565329a23aff50c9762181810166f3c15b078cca522f930d1a2747778893232336bffd1ea5d2ca60543f1801d4360ea63a@10.0.1.226:0?discport=30301 --networkid 4004181 --rpcaddr 0.0.0.0 --rpcapi admin,eth,net --rpc --rpccorsdomain "*" --miner.etherbase 0xb46d14ef42ac9bb01303ba1842ea784e2460c7e7 --miner.noverify --mine

#FULLENODE=$(echo enode://$(cat /root/multinet/repo/data/$MULTINET_POD_NAME/enode.txt)@$MULTINET_POD_IP:30303);
#WALLET_ADDRESS=$(cat "/root/multinet/repo/data/common/addresses/$MULTINET_POD_NAME.txt");
#echo "waiters are starting";
#
#while  [ ! -f /root/multinet/repo/data/common/enodes.txt ]; do
#  sleep 5;
#done
#
#echo "Catalyst grep on $MULTINET_POD_NAME"
#
#if grep -q "teku-catalyst" /root/multinet/repo/data/common/enodes.txt; then
#  sed -i -e "s~$MULTINET_POD_NAME~$FULLENODE~g" /root/multinet/repo/data/common/enodes.txt
#fi
#
#while grep -q "teku-catalyst" /root/multinet/repo/data/common/enodes.txt; do
#  sleep 5;
#done
#
##cp /root/multinet/repo/data/common/UTC--2021-01-18T17-33-56.364337282Z--3a98976b3a0261038aac8dee8d47a225e2f831c3 /root/multinet/repo/data/$MULTINET_POD_NAME/keystore/
#
#./geth --datadir /root/multinet/repo/data/$MULTINET_POD_NAME account import "/root/multinet/repo/data/common/private_keys/$MULTINET_POD_NAME.txt" --password "/root/multinet/repo/data/common/node.pwds"
#
#cp /root/multinet/repo/data/common/enodes.txt /root/multinet/repo/data/$MULTINET_POD_NAME/geth/static-nodes.json
#cp /root/multinet/repo/data/common/enodes.txt /root/multinet/repo/data/$MULTINET_POD_NAME/geth/trusted-nodes.json
#./geth --rpc --rpcapi net,eth,eth2,web3,personal,admin,db,debug,miner,shh,txpool --etherbase $WALLET_ADDRESS --datadir /root/multinet/repo/data/$MULTINET_POD_NAME --rpccorsdomain "*" --rpcaddr "$MULTINET_POD_IP" --verbosity 5 --ethstats "$MULTINET_POD_NAME:$CATALYST_STATS_LOGIN_SECRET@$CATALYST_STATS_HOST:80" --unlock 0 --password "/root/multinet/repo/data/common/node.pwds" --targetgaslimit '9000000000000' --allow-insecure-unlock --txpool.processtxs  --txpool.accountslots 10000 --txpool.accountqueue 20000
#echo "Done";
