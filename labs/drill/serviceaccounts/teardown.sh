#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-service-accounts.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/banana-deployment.yaml
echo "Teardown complete"
