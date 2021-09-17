# Lukso infrastructure helm scripts

Startup scripts for multiclient interop testnet. Currently only the scripts for nimbus and lighthouse have been kept up-to-date.

# Kubernetes any topology cluster

## Spin cluster with helm

### If you need a kubernetes local cluster use kind - *Optional*

https://kind.sigs.k8s.io/docs/user/quick-start/

```
GO111MODULE="on" go get sigs.k8s.io/kind@v0.8.1
kind create cluster
```

### Setup helm

```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```

### Using a development slot

## Google Cloud Engine (GKE) Kubernetes
In order to make `ReadWriteMany` on `common-data.yaml` and `deposits-storage.yml` you need to create NFS within region.
To do this you must create 2 compute disks. One for common-data and one for deposits-storage
Lets assume that you are using europe-west4-a for your GKE.
Example using gcloud sdk:
`gcloud compute disks create --size=200GB --zone=europe-west4-a nfs-data`
`gcloud compute disks create --size=200GB --zone=europe-west4-a nfs-deposit`
Notice that `nfs-disk` must match helm charts name, so in order to experiment with rename you must also rename it there.

To apply changes use:
`helm upgrade -f $PWD/multinet-cluster/values.yaml eth20 $PWD/multinet-cluster`

When you want to expose eth2stats you need to export external ips:
https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/

Example of exposure:
`kubectl expose deployment eth2stats-server --type=LoadBalancer --name=svrbalancer`
`kubectl expose deployment eth2stats-dashboard --type=LoadBalancer --name=dashbalancer`
`kubectl expose deployment launchpad-dashboard --type=LoadBalancer --name=launchpadbalancer`

What is problematic is the config of ethstats.

# License

CC0 (Creative Common Zero)
