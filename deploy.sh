docker build -t rishikant42/multi-client:latest -t rishikant42/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rishikant42/multi-server:latest -t rishikant42/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rishikant42/multi-worker:latest -t rishikant42/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rishikant42/multi-client:latest
docker push rishikant42/multi-server:latest
docker push rishikant42/multi-worker:latest

docker push rishikant42/multi-client:$SHA
docker push rishikant42/multi-server:$SHA
docker push rishikant42/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=rishikant42/multi-client:$SHA
kubectl set image deployment/server-deployment server=rishikant42/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=rishikant42/multi-worker:$SHA