# Pkl ArgoCD Configuration Management Plugin

A simple [configuration management plugin](https://argo-cd.readthedocs.io/en/stable/operator-manual/config-management-plugins)
for argocd that uses [pkl](https://pkl-lang.org/index.html).

## Installation

The installation is kind of tricky since you'll have to patch argocd-repo-server
as described [here](https://argo-cd.readthedocs.io/en/stable/operator-manual/config-management-plugins/#register-the-plugin-sidecar).

For reference, check out the `install` target in [Makefile](./Makefile) and files in
[local_test](./local_test), which installs the plugin in a local test cluster with kustomize.

## Local Development

Start a local kubenetes cluster with [kind](https://kind.sigs.k8s.io/),
and install argocd in the cluster:

```
make argocd
```

Patch argocd-repo-server to install the plugin:

```
make install
```

Create a test application:

```
kubectl --context kind-argocd-test apply -f test_apps/basic.yaml
```

Forward port from argocd server to use the ArgoCD UI:

```
make argocd/portforward
```
