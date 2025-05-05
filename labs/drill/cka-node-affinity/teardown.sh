#!/bin/bash
set -euo pipefail

kubectl delete pod ssd-affinity-pod --ignore-not-found=true --grace-period=0 --force
kubectl label node node-1 disktype- --overwrite

echo "✅ Teardown complete"
