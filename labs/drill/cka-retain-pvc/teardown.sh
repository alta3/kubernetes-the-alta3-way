#!/bin/bash
set -euo pipefail

kubectl delete pvc retained-pvc --ignore-not-found=true
kubectl get pv | grep fast-storage | awk '{print $1}' | xargs -r kubectl delete pv --quiet
kubectl delete storageclass fast-storage --ignore-not-found=true

echo "✅ Teardown complete"
