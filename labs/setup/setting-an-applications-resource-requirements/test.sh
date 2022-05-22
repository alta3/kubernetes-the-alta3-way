#!/bin/bash
set -xeuo pipefail 

kubectl apply -f ../yaml/linux-pod-r.yaml
kubectl wait --for condition=Ready --timeout 30s pod/linux-pod-r
kubectl apply -f ../yaml/linux-pod-rl.yaml
kubectl wait --for condition=Ready --timeout 30s pod/linux-pod-rl
