# Simple Helm plugin

The directory path to the shell scripts will need to be updated based on how you mount them
into the sidecar.

## Installation

```shell
kustomize build plugin | kubectl apply -n argocd -f -
```
