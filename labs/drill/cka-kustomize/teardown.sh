#!/bin/bash
set -euo pipefail

kubectl delete -k ~/kustomize/overlay-prod --ignore-not-found=true
rm -rf ~/kustomize

echo "✅ Teardown complete"
