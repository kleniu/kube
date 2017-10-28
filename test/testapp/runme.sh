set -e
eval $(minikube docker-env)
docker build -t test-node:v1 .
docker images
kubectl create -f test-node.yaml
kubectl create -f test-node-srvc.yaml


#kubectl run test-node --image=test-node:v1 --port=3000
#kubectl get deployments
#kubectl get pods
#kubectl get events
#kubectl expose deployment test-node --type=LoadBalancer
#kubectl get services
#kubectl scale deployment test-node --replicas=5
#kubectl get deployments

minikube service test-node-srvc

