#!/bin/bash

echo "Running pandora bootnode";

apt update &&
yes | apt install wget &&

wget https://storage.googleapis.com/l16-common/pandora/bootnode -O ./bootnode &&
chmod +x ./bootnode
./bootnode -nodekeyhex 5ad02bf648b850a44829d9b38976b1b01ddd000fc4c6099ff54aebf4ea07b867


