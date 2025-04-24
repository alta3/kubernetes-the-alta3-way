#!/bin/bash
set -euo pipefail

# Install Helm if not already installed
if ! command -v helm &>/dev/null; then
  curl -sSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

# Make sure Helm is ready to use
helm version &>/dev/null || {
  echo "❌ Helm installation failed."
  exit 1
}

# Add Traefik repo and update charts
helm repo add traefik https://traefik.github.io/charts &>/dev/null || true
helm repo update &>/dev/null

echo "✅ Environment ready"
