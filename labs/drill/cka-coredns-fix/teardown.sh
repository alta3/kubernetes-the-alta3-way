#!/bin/bash
set -euo pipefail

# Restore correct CoreDNS configuration
kubectl -n kube-system get configmap coredns -o yaml |
  sed 's/kubernetess/kubernetes/' |
  kubectl apply -f -

# Restart CoreDNS to apply the fix
kubectl -n kube-system delete pod -l k8s-app=kube-dns

echo "✅ Teardown complete"
