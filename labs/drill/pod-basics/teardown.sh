#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-basic-pods.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/singer.yaml
echo "Teardown complete"
