#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/nginx-annot.yaml
kubectl wait --for condition=Ready --timeout 10s pod/nginx-annot
kubectl get pods
