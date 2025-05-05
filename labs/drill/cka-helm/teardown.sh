#!/bin/bash
set -euo pipefail

helm uninstall nginx -n web &>/dev/null || true
kubectl delete ns web --ignore-not-found=true

echo "✅ Teardown complete"
