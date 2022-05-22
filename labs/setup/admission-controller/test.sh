#!/bin/bash
set -xeuo pipefail

kubectl run no-lr --image=nginx:1.19.6
kubectl wait --for condition=Ready --timeout 30s pod/no-lr
kubectl apply -f ../yaml/lim-ran.yml
kubectl get limitrange
