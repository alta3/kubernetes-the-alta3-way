#!/bin/bash
set -xeuo pipefail

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl -n kube-system wait --for condition=Available deployment.apps/metrics-server
kubectl top nodes
kubectl top pods --all-namespaces
