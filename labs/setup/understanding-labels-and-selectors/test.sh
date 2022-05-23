#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/nginx-pod.yaml
kubectl wait --for condition=Ready --timeout 30s -f pod/nginx
kubectl apply -f ../yaml/nginx-obj.yaml
kubectl wait --for condition=Ready --timeout 30s -f pod/nginx
