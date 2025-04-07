#!/bin/bash

set -euo pipefail

echo "=== Network Troubleshooting Teardown ==="

# Delete the main manifest file if it exists
if [ -e ~/mycode/yaml/ctce-drill-network-troubleshooting.yaml ]; then
  echo "Deleting resources from ctce-drill-network-troubleshooting.yaml..."
  kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-network-troubleshooting.yaml
else
  echo "Manifest file not found: ~/mycode/yaml/ctce-drill-network-troubleshooting.yaml"
fi

# Clean up any manually created test pods (e.g., tmp-shell, client)
echo "Cleaning up potential test pods..."
kubectl delete pod tmp-shell --ignore-not-found
kubectl delete pod client --ignore-not-found

echo "Teardown complete."
