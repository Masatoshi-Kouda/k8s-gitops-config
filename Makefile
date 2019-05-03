#############################
# deploy tiller
#############################
deploy.tiller:
	kubectl apply -f tiller/clusterrolebinding.yaml
	kubectl apply -f tiller/serviceaccount.yaml
	helm init --service-account tiller
