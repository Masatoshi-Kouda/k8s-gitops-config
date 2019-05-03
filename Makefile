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
