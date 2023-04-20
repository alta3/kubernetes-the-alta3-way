#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-secrets.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/juicysecret.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/kiwi-secret-pod.yaml
echo "Teardown complete"
