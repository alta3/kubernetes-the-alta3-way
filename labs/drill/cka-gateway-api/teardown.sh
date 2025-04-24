#!/bin/bash
set -euo pipefail

# Quietly delete all lab-created objects
kubectl delete gateway web-entrypoint --ignore-not-found=true
kubectl delete httproute web-route --ignore-not-found=true
kubectl delete svc web-backend --ignore-not-found=true
kubectl delete deploy web-backend --ignore-not-found=true

echo "✅ Teardown complete"
