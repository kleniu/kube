set -ve
eval $(minikube docker-env)
docker build -t rsvpapp:v1 .
docker pull mongo:3.3
kubectl create -f rsvp-db.yaml
kubectl create -f rsvp-db-service.yaml
kubectl create -f rsvp-web.yaml
kubectl create -f rsvp-web-service.yaml
