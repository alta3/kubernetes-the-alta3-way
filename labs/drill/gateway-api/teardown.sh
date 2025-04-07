#!/usr/bin/bash

set -euo pipefail

echo "STARTING TEARDOWN ----------"

# Step 0: Delete the backend service and deployment
echo "Deleting backend target service/deployment..."
if [ -e ~/mycode/yaml/nginx-backend.yaml ]; then
  kubectl delete --ignore-not-found -f ~/mycode/yaml/nginx-backend.yaml > /dev/null 2>&1
else
  echo "Backend manifest not found: ~/mycode/yaml/nginx-backend.yaml"
fi

# Step 1: Delete the NGINX Gateway Fabric Controller
echo "Deleting NGINX Gateway Fabric Controller..."
kubectl delete --ignore-not-found -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/default/deploy.yaml > /dev/null 2>&1

# Step 2: Delete the NGINX Gateway Fabric CRDs
echo "Deleting NGINX Gateway Fabric CRDs..."
kubectl delete --ignore-not-found -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v1.6.2/deploy/crds.yaml > /dev/null 2>&1

# Step 3: Delete the Gateway API CRDs (via kustomize)
echo "Deleting Gateway API CRDs..."
kubectl kustomize "https://github.com/nginx/nginx-gateway-fabric/config/crd/gateway-api/standard?ref=v1.6.2" | kubectl delete --ignore-not-found -f - > /dev/null 2>&1

# Step 4: Remove the NGINX site config from the host
echo "Removing NGINX site config..."
sudo rm -f /etc/nginx/sites-enabled/demo-ingress > /dev/null 2>&1

# Step 5: Reload NGINX to apply config removal
echo "Reloading NGINX on host..."
sudo nginx -t > /dev/null 2>&1 && sudo nginx -s reload > /dev/null 2>&1

echo "TEARDOWN COMPLETE ----------"
