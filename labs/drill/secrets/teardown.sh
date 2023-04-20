#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-secrets.yaml
kubectl delete --ignore-not-found -f ~/juicysecret.yaml
kubectl delete --ignore-not-found -f ~/kiwi-secret-pod.yaml
echo "Teardown complete"
