#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/badpod.yaml
kubectl wait --for condition=Ready --timeout 30s pod/badpod
kubectl apply -f ../yaml/sise-lp.yaml
kubectl wait --for condition=Ready --timeout 30s pod/sise-lp
kubectl apply -f ../yaml/sise-rp.yaml
kubectl wait --for condition=Ready --timeout 30s pod/sise-rp

kubectl get pods # expect badpod to be restarted
