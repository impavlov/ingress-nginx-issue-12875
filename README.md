# ingress-nginx-issue-12875

## Steps
* install and `minikube start`. Minikube is needed for building in-cluster image.
* `make setup`
* `make forward` (in one tab)
* `make generate`
* `make build`
* `make curl` (in another tab)
