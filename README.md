# Multi-client interop scripts

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

### Load images (only if you use *kind*) - *Optional*

**Images are available on dockerhub actually, they are built daily, so this is completely optional**

```
cd scripts

docker build --target multinet-nimbus -t eth2clients/multinet-nimbus .
kind load docker-image multinet-nimbus --name kind

docker build --target multinet-lighthouse -t eth2clients/multinet-lighthouse .
kind load docker-image multinet-lighthouse --name kind

docker build --target multinet-prysm -t eth2clients/multinet-prysm .
kind load docker-image multinet-prysm --name kind
```

### Finally start the cluster

*Customize `multinet-cluster/values.yaml`*

```
helm install $DEPLOYMENT_NAME ./multinet-cluster  
```
where `$DEPLOYMENT_NAME` is your name choice

### Using a development slot

#### Nimbus basic example

**`NIMBUS_DEV_NODES` must be more then 0 in `values.yaml`**

1. `kubectl exec --stdin --tty nimbus-dev-0 -- /bin/bash`
2. `cd nimbus-src`
3. `make update`
4. `source env.sh`
2. `NIMFLAGS="-d:insecure -d:chronicles_log_level=TRACE --warnings:off --hints:off --opt:speed -d:const_preset=/root/multinet/repo/data/testnet/config.yaml"`
3. `nim c -o:beacon_node $NIMFLAGS beacon_chain/beacon_node`
4. `./beacon_node --state-snapshot:/root/multinet/repo/data/testnet/genesis.ssz --bootstrap-file=/root/multinet/repo/data/testnet/bootstrap_nodes.txt`

# Enodes propagation
(temporary solution)

You need to put NAMES of every pod into `static-nodes.json`
before deploying. They will be replaced with enodes by script in genesis container.  
The length of array must match `TEKU_CATALYST_NODES` from `values.yaml`
Example config for 8 nodes:
```json
[
  "teku-catalyst-0",
  "teku-catalyst-1",
  "teku-catalyst-2",
  "teku-catalyst-3",
  "teku-catalyst-4",
  "teku-catalyst-5",
  "teku-catalyst-6",
  "teku-catalyst-7"
]
```

## TODO

- [ ] Deploy to github actions image building

# Running just 3 nodes with docker-compose

```
cd scripts
docker-compose up
```

## Inspecting the source

Use the respective docker volumes, just simply attach from another container e.g.:
```
docker run -it --rm -v nimbus-source:/tmp/nimbus ubuntu bash
```
Using this trick you could even attach via visual studio code and SSH integration.

## Google Cloud Engine (GKE) Kubernetes
In order to make `ReadWriteMany` on `common-data.yaml` and `deposits-storage.yml` you need to create NFS within region.
To do this you must create 2 compute disks. One for common-data and one for deposits-storage
Lets assume that you are using europe-west4-a for your GKE.
Example using gcloud sdk:
`gcloud compute disks create --size=200GB --zone=europe-west4-a nfs-data`
`gcloud compute disks create --size=200GB --zone=europe-west4-a nfs-deposit`
Notice that `nfs-disk` must match helm charts name, so in order to experiment with rename you must also rename it there.

After creating disk you must deploy nfs using kubectl.
Example from root of this repo:
`./nfs/reapply.sh`

Files should be mounted to `/data/$DIR` where `$DIR` is with consecutive: 
`data` for common-data.yml
`depostits` for deposits-storage.yml

In order to check whats going on on disk itself do:
`kubectl exec -it $NFS_SERVER_POD_NAME bash`

To check `$NFS_SERVER_POD_NAME` do `kubectl get pods`

To apply changes use:
`helm upgrade -f $PWD/multinet-cluster/values.yaml eth20 $PWD/multinet-cluster`

When you want to expose eth2stats you need to export external ips:
https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/

Example of exposure:
`kubectl expose deployment eth2stats-server --type=LoadBalancer --name=svrbalancer`
`kubectl expose deployment eth2stats-dashboard --type=LoadBalancer --name=dashbalancer`
`kubectl expose deployment launchpad-dashboard --type=LoadBalancer --name=launchpadbalancer`

What is problematic is the config of ethstats.

### Copy the contents of logs from kubernetes pods
Example for teku:
`kubectl cp teku-catalyst-4:/root/.local/share/teku/logs/teku.log ./teku-log-4 -c teku`

### Prysm validator build

1. Build `multinet-prysm` by using dockerfile from project root.
2. Push tagged image (e.g. `silesiacoin/multinet-prysm:v8`) to the silesiacoin docker hub.
3. Change `image` to latest one inside `multinet-cluster/templates/prysm.yaml` template (`image: silesiacoin/multinet-prysm:v7`)
4. Run `helm upgrade` command - you can delete prysm pod to be sure about the latest image contribution.

# License

CC0 (Creative Common Zero)

# Known issues

* For some reason (due to the `build.rs` in `deposit_contract` project) lighthouse will need to build again (we built already in the Dockerfile...) the first time `docker-compose up` will run.
* If you spin new network with catalyst and teku  `ETH_2_GENESIS_TIME` in `multinet-cluster/values.yml` cannot be too old. The best approach is to get current timestamp and inject into `multinet-cluster/values.yml`. TL:DR; `https://www.unixtimestamp.com/index.php`  

## Generate genesis and config files for l16-multinet (for l16-common cloud storage)

1. Use`generate_genesis.sh` to create/update new genesis and config files: `vanguard_private_testnet_genesis.ssz`,
`pandora_private_testnet_genesis.json` and `chain-config.yaml`.
2. Upload all these 3 files to `l16-common` google cloud storage by replacing existing files in `vanguard` and `pandora` directories.
3. Make them public by `EDIT PERMISSIONS`.
4. Set cache for every file by `EDIT METADATA` and set for field `Cache-control` this value: `public, max-age=60`.
`max-age=60` means 1min cache.
   
Points no. 3 and 4 -> you can find these `EDIT` buttons when you chose (click on) concrete file.
