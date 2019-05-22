docker build -t marekstrejczek/multi-client:latest -t marekstrejczek/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t marekstrejczek/multi-server:latest -t marekstrejczek/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t marekstrejczek/multi-worker:latest -t marekstrejczek/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push marekstrejczek/multi-client:latest
docker push marekstrejczek/multi-server:latest
docker push marekstrejczek/multi-worker:latest
docker push marekstrejczek/multi-client:$GIT_SHA
docker push marekstrejczek/multi-server:$GIT_SHA
docker push marekstrejczek/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=marekstrejczek/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=marekstrejczek/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=marekstrejczek/multi-worker:$GIT_SHA
