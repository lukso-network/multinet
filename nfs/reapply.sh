#!/bin/bash
#WARNING: run this from root of the project

# delete old nfs deployment
kubectl delete -f $PWD/nfs/deployment-data.yaml --namespace default
kubectl delete -f $PWD/nfs/deployment-deposit.yaml --namespace default
kubectl delete -f $PWD/nfs/service-data.yaml --namespace default
kubectl delete -f $PWD/nfs/service-deposit.yaml --namespace default

#apply new nfs deployment
kubectl apply -f $PWD/nfs/deployment-data.yaml --namespace default
kubectl apply -f $PWD/nfs/deployment-deposit.yaml --namespace default
kubectl apply -f $PWD/nfs/service-data.yaml --namespace default
kubectl apply -f $PWD/nfs/service-deposit.yaml --namespace default

