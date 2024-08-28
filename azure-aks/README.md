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

Clean kubectl config

```sh
$ kubectl config delete-context lab-01-aks-test1
$ kubectl config delete-cluster lab-01-aks-test1
$ kubectl config delete-user clusterUser_lab-01-rg_lab-01-aks-test1
```
