#!/usr/bin/bash

set -euo pipefail

echo "STARTING NGINX GATEWAY FABRIC SETUP ----------"

# Step 1: Install Gateway API CRDs using kustomize
echo "Installing Gateway API CRDs..."
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.2" | kubectl apply -f - > /dev/null 2>&1

# Step 2: Apply additional NGINX Gateway Fabric CRDs
echo "Applying NGINX Gateway Fabric CRDs..."
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/crds.yaml > /dev/null 2>&1

# Wait for critical CRDs to be fully established before proceeding
echo "Waiting for CRDs to become established..."
kubectl wait --for=condition=Established crd/gatewayclasses.gateway.networking.k8s.io --timeout=60s > /dev/null 2>&1
kubectl wait --for=condition=Established crd/nginxgateways.gateway.nginx.org --timeout=60s > /dev/null 2>&1

echo "Waiting for CRDs to be usable by the API server..."

until kubectl get gatewayclass > /dev/null 2>&1; do
  echo "Waiting for gatewayclass to become available..."
  sleep 2
done

until kubectl get nginxgateway > /dev/null 2>&1; do
  echo "Waiting for nginxgateway to become available..."
  sleep 2
done

# Step 3: Deploy NGINX Gateway Fabric Controller
echo "Deploying NGINX Gateway Fabric Controller..."
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/default/deploy.yaml > /dev/null 2>&1

# Step 4: Wait for the controller to be running
echo "Waiting for NGINX Gateway controller to become ready..."
kubectl wait --namespace nginx-gateway \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/name=nginx-gateway \
  --timeout=90s > /dev/null 2>&1

# Step 5: Verify the GatewayClass exists and is accepted
echo "Verifying GatewayClass..."
kubectl wait gatewayclass/nginx \
  --for=jsonpath='{.status.conditions[?(@.type=="Accepted")].status}'=True \
  --timeout=30s > /dev/null 2>&1

# Step 6: Install NGINX site config
echo "Installing NGINX site configuration..."
sudo cp ~/mycode/yaml/demo-ingress-gateway-api /etc/nginx/sites-enabled/demo-ingress > /dev/null 2>&1

# Step 7: Test and reload NGINX config
echo "Reloading NGINX on host to apply configuration..."
sudo nginx -t > /dev/null 2>&1 && sudo nginx -s reload > /dev/null 2>&1

# Step 8: Patch the NGINX Gateway Service to expose nodePort 31200
echo "Patching NGINX Gateway Service to expose nodePort 31200..."
kubectl patch svc nginx-gateway -n nginx-gateway \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/ports/0/nodePort", "value": 31200}]' > /dev/null 2>&1

# Step 9: Load the Backend Service we're targetting
echo "Adding Target Service/Deployment"
kubectl apply -f ~/mycode/yaml/nginx-backend.yaml

echo "SETUP COMPLETE ----------"
