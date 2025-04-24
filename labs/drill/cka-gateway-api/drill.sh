#!/bin/bash
set -euo pipefail

echo "🔍 Checking if Gateway CRDs already exist..."
if kubectl get crd nginxgateways.gateway.nginx.org &>/dev/null; then
  echo "✅ Gateway CRDs already installed. Skipping."
else
  echo "🔧 Installing Gateway API CRDs..."
  kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.2" | kubectl apply -f -
  kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/crds.yaml
fi

echo "🔍 Checking if NGINX Gateway deployment exists..."
if kubectl get deployment -n nginx-gateway nginx-gateway &>/dev/null; then
  echo "✅ NGINX Gateway already deployed. Skipping deployment step."
else
  echo "🚀 Deploying NGINX Gateway Fabric Controller..."
  kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/default/deploy.yaml
fi

echo "⏳ Waiting for nginx-gateway pod to become ready..."
kubectl wait --namespace nginx-gateway \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=nginx-gateway \
  --timeout=120s

echo "🔍 Verifying GatewayClass..."
kubectl get gatewayclass nginx || echo "❌ GatewayClass not found!"
kubectl describe gatewayclass nginx || true

echo "🛠️ Checking if nginx-gateway service is using nodePort 31200..."
if kubectl get svc -n nginx-gateway nginx-gateway -o jsonpath='{.spec.ports[0].nodePort}' | grep -q 31200; then
  echo "✅ nginx-gateway service already using nodePort 31200."
else
  echo "🔧 Patching nginx-gateway service to use nodePort 31200..."
  kubectl patch svc -n nginx-gateway nginx-gateway \
    --type='json' \
    -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value":31200}]'
fi

echo "✅ Setup complete!"
