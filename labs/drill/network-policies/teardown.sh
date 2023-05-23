#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-network-policies.yaml
kubectl delete --ignore-not-found -f ~/cherry-control.yaml
echo "Teardown complete"
