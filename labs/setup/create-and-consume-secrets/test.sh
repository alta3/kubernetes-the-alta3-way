#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/mysql-secret.yaml
kubectl apply -f ../yaml/mysql-locked.yaml
kubectl wait --for condition=Ready --timeout 30s pod/mysql-locked
kubectl get pod mysql-locked
kubectl get secrets mysql-secret
