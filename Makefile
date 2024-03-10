k=kubectl --context kind-argocd-test

argocd:
	-kind create cluster -n argocd-test --config kind.yaml
	$k apply -f https://github.com/argoproj/argo-cd/raw/master/manifests/install.yaml

argocd/password:
	@echo Admin password: $(shell $k get secret argocd-initial-admin-secret -o json | jq -r .data.password | base64 -d)

argocd/port: argocd/password
	$k port-forward $(shell $k get pod -l "app.kubernetes.io/name=argocd-server" -o 'jsonpath={.items[0].metadata.name}') 8080:8080

install:
	$k get deployments.apps -o yaml argocd-repo-server > base/argocd-repo-server.yaml 
	kustomize build plugin | $k apply -f -

image:
	docker build -t argocd-pkl .
	kind load docker-image -n argocd-test argocd-pkl
