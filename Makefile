#############################
# deploy tiller
#############################
deploy.tiller:
	kubectl apply -f tiller/clusterrolebinding.yaml
	kubectl apply -f tiller/serviceaccount.yaml
	helm init --service-account tiller

deploy.argocd:
	kubectl create namespace argocd
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

deploy.flux-helm-release-crd:
	kubectl apply -f https://raw.githubusercontent.com/weaveworks/flux/master/deploy-helm/flux-helm-release-crd.yaml

deploy.flux:
	helm upgrade -i flux \
	--set helmOperator.create=true \
	--set helmOperator.createCRD=false \
	--set git.url=git@github.com:Masatoshi-Kouda/k8s-gitops-config \
	--set git.path=releases/develop \
	--namespace flux \
	weaveworks/flux
