#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-deployments.yaml
kubectl delete --ignore-not-found -f ~/manticore-deployment.yaml
echo "Teardown complete"
