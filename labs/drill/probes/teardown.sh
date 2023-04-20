#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-probes.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/plumpod.yaml
echo "Teardown complete"
