docker build -t coursesvirajetech/multi-client:latest -t coursesvirajetech/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t coursesvirajetech/multi-server:latest -t coursesvirajetech/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t coursesvirajetech/multi-worker:latest -t coursesvirajetech/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push coursesvirajetech/multi-client:latest
docker push coursesvirajetech/multi-server:latest
docker push coursesvirajetechr/multi-worker:latest

docker push coursesvirajetech/multi-client:$SHA
docker push coursesvirajetech/multi-server:$SHA
docker push coursesvirajetech/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=coursesvirajetech/multi-server:$SHA
kubectl set image deployments/client-deployment client=coursesvirajetech/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=coursesvirajetech/multi-worker:$SHA
