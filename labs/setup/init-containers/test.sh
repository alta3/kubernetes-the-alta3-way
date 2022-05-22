#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/init-cont-pod.yaml
kubectl apply -f ../yaml/myservice.yaml
kubectl apply -f ../yaml/mydb.yaml 
kubectl wait --for condition=Ready --timeout 30s -f ../yaml/init-cont-pod.yaml
kubectl get pods
