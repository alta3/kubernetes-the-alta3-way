#!/bin/bash
set -euo pipefail

kubectl delete pod dns-test --ignore-not-found=true

# Remove the custom hosts entry from CoreDNS ConfigMap
if kubectl get configmap coredns -n kube-system &>/dev/null; then
  kubectl get configmap coredns -n kube-system -o yaml |
    sed '/10.10.10.10 myapp.internal/d' |
    sed '/hosts {/,+2 d' |
    kubectl apply -f -

  # Restart CoreDNS
  kubectl delete pod -n kube-system -l k8s-app=kube-dns --ignore-not-found=true
fi

echo "✅ Teardown complete"
