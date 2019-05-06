deploy.minikube.gcr-secrets:
	./tmp/create-minikube-gcr-secrets.sh

deploy.tiller:
	kubectl apply -f tiller/clusterrolebinding.yaml
	kubectl apply -f tiller/serviceaccount.yaml
	helm init --service-account tiller

deploy.flux:
	kubectl apply -f https://raw.githubusercontent.com/weaveworks/flux/master/deploy-helm/flux-helm-release-crd.yaml
	kubectl create namespace flux
	kubectl apply -f flux/fluxcloud.yaml -n flux
	kubectl -n flux create secret generic helm-ssh --from-file=./tmp/identity
	kubectl -n flux create secret generic slack-url --from-file=./tmp/slack-url
	helm upgrade -i flux \
	-f flux/values.yaml \
	--namespace flux \
	weaveworks/flux
