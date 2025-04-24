#!/bin/bash
set -euo pipefail

helm uninstall traefik -n traefik &>/dev/null || true
kubectl delete ns traefik --ignore-not-found=true
kubectl delete gatewayclass traefik --ignore-not-found=true

echo "✅ Teardown complete"
