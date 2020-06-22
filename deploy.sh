docker build -t agrimolizzi/multi-client:latest -t agrimolizzi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t agrimolizzi/multi-server:latest -t agrimolizzi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t agrimolizzi/multi-worker:latest -t agrimolizzi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push agrimolizzi/multi-client:latest
docker push agrimolizzi/multi-server:latest
docker push agrimolizzi/multi-worker:latest

docker push agrimolizzi/multi-client:$SHA
docker push agrimolizzi/multi-server:$SHA
docker push agrimolizzi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=agrimolizzi/multi-server:$SHA
kubectl set image deployments/client-deployment client=agrimolizzi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=agrimolizzi/multi-worker:$SHA