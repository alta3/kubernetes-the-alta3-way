#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-deployments.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/manticore-deployment.yaml
echo "Teardown complete"
