#!/bin/bash
set -euo pipefail

kubectl delete pod dedicated-pod --grace-period=0 --force --ignore-not-found=true
kubectl taint node node-1 dedicated=experimental:NoSchedule- --overwrite >/dev/null 2>&1

echo "✅ Teardown complete"
