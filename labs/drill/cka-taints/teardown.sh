#!/bin/bash
set -euo pipefail

kubectl delete pod dedicated-pod testpod --ignore-not-found=true
kubectl get node node-1 -o json | grep -q '"key": "dedicated", "value": "experimental", "effect": "NoSchedule"' && \
kubectl taint nodes node-1 dedicated=experimental:NoSchedule- --overwrite

echo "✅ Teardown complete"
