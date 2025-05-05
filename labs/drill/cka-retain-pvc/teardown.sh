#!/bin/bash
set -euo pipefail

kubectl delete pod test-pod --ignore-not-found=true --grace-period=0 --force
kubectl delete pvc retained-pvc --ignore-not-found=true
kubectl delete pv --all --ignore-not-found=true
kubectl delete sc fast-storage --ignore-not-found=true

echo "✅ Teardown complete"
