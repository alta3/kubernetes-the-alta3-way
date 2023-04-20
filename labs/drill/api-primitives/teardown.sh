#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" pods apricot -n pineapple
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-api-primitives.yaml
echo "Teardown complete"
