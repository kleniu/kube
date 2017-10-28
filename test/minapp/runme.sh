set -e
eval $(minikube docker-env)
docker build -t hello-node:v1 .
docker images
kubectl run hello-node --image=hello-node:v1 --port=8080
kubectl get deployments
kubectl get pods
kubectl get events
kubectl expose deployment hello-node --type=LoadBalancer
kubectl get services
minikube service hello-node
