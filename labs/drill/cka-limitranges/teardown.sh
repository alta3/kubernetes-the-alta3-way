#!/bin/bash
set -euo pipefail

# Create the namespace if it doesn't exist
kubectl delete namespace limit-test --ignore-not-found=true

echo "✅ Environment ready"
