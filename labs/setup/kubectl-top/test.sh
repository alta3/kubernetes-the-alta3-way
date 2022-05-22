#!/bin/bash
set -xeuo pipefail

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl -n kube-system wait --for condition=Available --timeout 100s deployment.apps/metrics-server
kubectl -n kube-system wait --for condition=Available --timeout 30s apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io
kubectl top nodes
kubectl top pods --all-namespaces
