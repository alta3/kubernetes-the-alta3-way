#!/bin/bash
set -euo pipefail
kubectl rollout undo deployment -n king-of-lions mufasa
kubectl delete deploy -n king-of-lions mufasa
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-busted-deployment.yaml
echo "Teardown complete"
