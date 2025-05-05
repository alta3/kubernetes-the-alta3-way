#!/bin/bash
set -euo pipefail

kubectl delete statefulset web --ignore-not-found=true
kubectl delete svc web --ignore-not-found=true
kubectl delete svc -l app=web --ignore-not-found=true

echo "✅ Teardown complete"
