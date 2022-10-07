# Flux demo

1. Create cluster

```shell
cd cluster/
terraform init
terraform apply -auto-approve
cd -
```

`kubeconfig.yaml` is generated in the repo's root.

```shell
export KUBECONFIG=kubeconfig.yaml
```

2. Deploy Flux

```shell
kustomize build flux/ | kubectl apply -f -
```

3. Configure Flux "syncs"

```shell
kustomize build config/ | kubectl apply -f -
```
