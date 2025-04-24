#!/bin/bash
set -euo pipefail

kubectl delete pod ssd-affinity-pod --ignore-not-found=true
kubectl label node node-1 disktype- --overwrite

echo "✅ Teardown complete"
