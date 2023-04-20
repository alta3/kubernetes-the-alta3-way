#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-security-contexts.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/gold-bar.yaml
echo "Teardown complete"
