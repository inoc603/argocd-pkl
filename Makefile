k=kubectl --context kind-argocd-test

argocd:
	-kind create cluster -n argocd-test --config kind.yaml
	-$k create ns argocd
	$(MAKE) image
	$k apply -n argocd -f https://github.com/argoproj/argo-cd/raw/master/manifests/install.yaml

argocd/password:
	@echo Admin password: $(shell $k get -n argocd secret argocd-initial-admin-secret -o json | jq -r .data.password | base64 -d)
	@-echo $(shell $k get -n argocd secret argocd-initial-admin-secret -o json | jq -r .data.password | base64 -d) | pbcopy

argocd/portforward: argocd/password
	$k port-forward -n argocd $(shell $k -n argocd get pod -l "app.kubernetes.io/name=argocd-server" -o 'jsonpath={.items[0].metadata.name}') 8080:8080

install: image
	$k -n argocd get deployments.apps -o yaml argocd-repo-server > local_test/argocd-repo-server.yaml 
	kustomize build local_test | $k apply -f -

image:
	docker build -t argocd-pkl ./plugin
	kind load docker-image -n argocd-test argocd-pkl

reload:
	$(MAKE) install
	$k delete pod -n argocd -l 'app.kubernetes.io/name=argocd-repo-server'
