#!/bin/bash
set -euo pipefail

# Apply Metrics Server (if not already running)
if ! kubectl top node &>/dev/null; then
  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
  echo "⌛ Waiting for metrics-server to be ready..."
  kubectl wait --namespace kube-system --for=condition=Available deploy/metrics-server --timeout=120s || true
fi

echo "✅ Environment ready"
