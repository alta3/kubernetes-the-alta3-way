#!/bin/bash
set -euo pipefail

# Ensure the local-path provisioner supports fast-storage
kubectl -n local-path-storage get cm local-path-config -o yaml | grep 'fast-storage:' >/dev/null 2>&1 || {
  kubectl -n local-path-storage get configmap local-path-config -o yaml > /tmp/lpc.yaml
  yq e '.data["config.json"]' /tmp/lpc.yaml | \
    yq e '.storageClassMap["fast-storage"] = {
      "hostDir": "/opt/local-path-provisioner",
      "mountDir": "/opt/local-path-provisioner",
      "blockCleanerCommand": ["/scripts/shred.sh", "2", "0"],
      "volumeBindingMode": "Immediate"
    }' - > /tmp/lpc-patched.json

  kubectl -n local-path-storage patch configmap local-path-config --type merge \
    --patch "$(jq -n --argjson data "{\"config.json\":$(cat /tmp/lpc-patched.json | jq -Rs .)}" '{data: $data}')"

  kubectl -n local-path-storage delete pod -l app=local-path-provisioner --wait
}

echo "✅ Environment ready"
