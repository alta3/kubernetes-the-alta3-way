#!/bin/bash
set -euo pipefail

# Create the namespace if it doesn't exist
kubectl get ns limit-test &>/dev/null || kubectl create namespace limit-test

echo "✅ Environment ready"
