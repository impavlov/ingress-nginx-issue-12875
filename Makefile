build:
	eval $$(minikube docker-env) && docker build -t go-upload-server .
	kubectl delete --ignore-not-found=true -f app.yaml
	kubectl delete --ignore-not-found=true pod -l app=app
	kubectl apply -f app.yaml
	kubectl wait --for=condition=ready pod -l app=app

setup: build
	dd if=/dev/urandom of=10M bs=1M count=1
	kubectl apply -f https://kind.sigs.k8s.io/examples/ingress/deploy-ingress-nginx.yaml
	kubectl -n ingress-nginx wait --for=condition=ready pod -l app.kubernetes.io/component=controller
	kubectl -n ingress-nginx port-forward svc/ingress-nginx-controller 8080:80

curl:
	curl -d @10M http://localhost:8080/upload > /dev/null	
#curl -X POST -H "Content-Type: application/x-git-upload-pack-request" -d @10M http://localhost:8080/upload
#curl -X PATCH -H "Content-Type: application/octet-stream" -d @10M http://localhost:8080/upload

reproduce:
	./reproduce.sh
	kubectl -n ingress-nginx logs --tail=5 -l app.kubernetes.io/component=controller
