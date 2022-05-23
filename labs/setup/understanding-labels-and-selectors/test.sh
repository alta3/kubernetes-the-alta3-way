#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/nginx-pod.yaml
kubectl wait --for condition=Ready --timeout 30s pod/nginx
kubectl apply -f ../yaml/nginx-obj.yaml
kubectl wait --for condition=Available --timeout 30s deployment.apps/nginx-obj-create
