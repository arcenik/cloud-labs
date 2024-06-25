# Testing AKS Kubernetes deployment

## Deploy

```sh
$ tofu init
$ tofu apply
$ tofu state list
azurerm_kubernetes_cluster.test1
azurerm_resource_group.main
```

## Using

```sh
$ k config get-clusters
NAME
lab-01-aks-test1
```

## Destroy

```sh
$ tofu destroy
...
azurerm_kubernetes_cluster.test1: Destruction complete after 3m25s
...
```
