#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/alta3-pv.yaml
kubectl delete --ignore-not-found -f ~/nginx-pvc.yaml
kubectl delete --ignore-not-found -f ~/nginx-with-pv.yaml
echo "Teardown complete"
