docker build -t harryyy27/multi-client:latest -t harryyy27/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harryyy27/multi-server:latest -t harryyy27/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harryyy27/multi-worker:latest -t harryyy27/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push harryyy27/multi-client:latest
docker push harryyy27/multi-server:latest
docker push harryyy27/multi-worker:latest

docker push harryyy27/multi-client:$SHA
docker push harryyy27/multi-server:$SHA
docker push harryyy27/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=harryyy27/multi-server:$SHA
kubectl set image deployments/client-deployment client=harryyy27/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=harryyy27/multi-worker:$SHA
