#!/bin/bash
set -euo pipefail

kubectl delete deployment cpu-demo --ignore-not-found=true
kubectl delete hpa cpu-demo-hpa --ignore-not-found=true

echo "✅ Teardown complete"
