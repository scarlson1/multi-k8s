docker build -t spencercarlson/multi-client:latest -t spencercarlson/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t spencercarlson/multi-server:latest -t spencercarlson/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t spencercarlson/multi-worker:latest -t spencercarlson/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push spencercarlson/multi-client:latest
docker push spencercarlson/multi-server:latest
docker push spencercarlson/multi-worker:latest

docker push spencercarlson/multi-client:$SHA
docker push spencercarlson/multi-server:$SHA
docker push spencercarlson/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=spencercarlson/multi-server:$SHA
kubectl set image deployments/client-deployment client=spencercarlson/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=spencercarlson/multi-worker:$SHA