#!/bin/bash
set -xeuo pipefail

kubectl apply -f  ../yaml/test-ns.yaml
kubectl apply -f  ../yaml/dev-ns.yaml
kubectl apply -f  ../yaml/prod-ns.yaml
kubectl apply -f  ../yaml/test-rq.yaml --namespace=test
kubectl apply -f  ../yaml/prod-rq.yaml --namespace=prod
kubectl apply -f  ../yaml/prod-rq.yaml --namespace=prod
kubectl get namespaces dev prod test
