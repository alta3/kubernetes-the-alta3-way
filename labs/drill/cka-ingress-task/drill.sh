#!/bin/bash
set -euo pipefail

# Use newer Ingress NGINX version
VERSION="v1.10.1"

# Install ingress-nginx controller if not present
if ! kubectl get ns ingress-nginx &>/dev/null; then
  echo "✨ Installing ingress-nginx controller ($VERSION)..."
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-$VERSION/deploy/static/provider/baremetal/deploy.yaml
else
  echo "✅ ingress-nginx namespace already exists. Skipping controller install."
fi

# Wait for the controller to become ready
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=120s

# Patch HTTPS NodePort to 31224 if needed
echo "🔧 Patching HTTPS NodePort to 31224..."
kubectl patch svc ingress-nginx-controller -n ingress-nginx --type='json' -p='[
  {
    "op": "replace",
    "path": "/spec/ports/1/nodePort",
    "value": 31224
  }
]' || true

echo "✅ Setup complete. Begin the Ingress lab!"
