#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/alta3-pv.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/nginx-pvc.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/nginx-with-pv.yaml
echo "Teardown complete"
