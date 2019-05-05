#############################
# deploy tiller
#############################
deploy.tiller:
	kubectl apply -f tiller/clusterrolebinding.yaml
	kubectl apply -f tiller/serviceaccount.yaml
	helm init --service-account tiller

deploy.flux-helm-release-crd:
	kubectl apply -f https://raw.githubusercontent.com/weaveworks/flux/master/deploy-helm/flux-helm-release-crd.yaml

deploy.flux:
	helm upgrade -i flux \
	--set helmOperator.create=true \
	--set helmOperator.createCRD=false \
	--set git.url=git@github.com:Masatoshi-Kouda/k8s-gitops-config \
	--set git.path=releases/develop \
	--set git.pollInterval=1m \
	--set registry.pollInterval=1m \
	--namespace flux \
	weaveworks/flux

fluxctl.identity:
	fluxctl identity --k8s-fwd-ns flux
