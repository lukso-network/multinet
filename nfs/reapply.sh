#!/bin/bash
#WARNING: run this from root of the project

# delete old nfs deployment
kubectl delete -f $PWD/nfs/deployment-data.yaml --namespace closed-testnet
kubectl delete -f $PWD/nfs/deployment-deposit.yaml --namespace closed-testnet
kubectl delete -f $PWD/nfs/service-data.yaml --namespace closed-testnet
kubectl delete -f $PWD/nfs/service-deposit.yaml --namespace closed-testnet

#apply new nfs deployment
kubectl apply -f $PWD/nfs/deployment-data.yaml --namespace closed-testnet
kubectl apply -f $PWD/nfs/deployment-deposit.yaml --namespace closed-testnet
kubectl apply -f $PWD/nfs/service-data.yaml --namespace closed-testnet
kubectl apply -f $PWD/nfs/service-deposit.yaml --namespace closed-testnet

