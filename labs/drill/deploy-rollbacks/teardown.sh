#!/bin/bash
set -euo pipefail
kubectl rollout undo deployment -n king-of-lions mufasa
kubectl delete deploy -n king-of-lions
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-busted-deployment.yaml
echo "Teardown complete"
