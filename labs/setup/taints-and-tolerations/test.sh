#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/tnt01.yaml
kubectl wait --for condition=Available --timeout 30s deployment.apps/nginx
kubectl delete -f ../yaml/tnt01.yaml
kubectl taint nodes node-1 trying_taints=yessir:NoSchedule
kubectl apply -f ../yaml/tnt01.yaml
kubectl wait --for condition=Available --timeout 30s deployment.apps/nginx
kubectl apply -f ../yaml/tnt02.yaml
kubectl wait --for condition=Available --timeout 30s deployment.apps/nginx-tolerated
kubectl get pods -o wide
