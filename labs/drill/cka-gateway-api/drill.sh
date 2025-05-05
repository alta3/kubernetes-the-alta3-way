#!/bin/bash
set -euo pipefail

# Install Gateway API CRDs and NGINX Gateway if not already installed

echo "🔍 Checking if Gateway CRDs already exist..."
if ! kubectl get crd gateways.gateway.networking.k8s.io &>/dev/null; then
  echo "🔧 Installing Gateway API CRDs..."
  kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.2" | kubectl apply -f -
  kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/crds.yaml
else
  echo "✅ Gateway CRDs already installed."
fi

# Deploy the NGINX Gateway Controller
if ! kubectl get deployment -n nginx-gateway nginx-gateway &>/dev/null; then
  echo "🚀 Deploying NGINX Gateway Fabric Controller..."
  kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/default/deploy.yaml
else
  echo "✅ NGINX Gateway already deployed."
fi

# Wait for the controller to be ready
kubectl wait --namespace nginx-gateway \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=nginx-gateway \
  --timeout=120s

# Patch service to use nodePort 31200 only if needed
PORT=$(kubectl get svc -n nginx-gateway nginx-gateway -o jsonpath='{.spec.ports[0].nodePort}' || echo "")
if [[ "$PORT" != "31200" ]]; then
  echo "🔧 Patching nginx-gateway service to use nodePort 31200..."
  kubectl patch svc -n nginx-gateway nginx-gateway \
    --type='json' \
    -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":31200}]'
else
  echo "✅ nginx-gateway service already using nodePort 31200."
fi

echo "✅ Setup complete!"
