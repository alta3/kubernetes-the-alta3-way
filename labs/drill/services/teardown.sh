#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-services.yaml
kubectl delete --ignore-not-found -f ~/lone-coconut.yaml
kubectl delete --ignore-not-found -f ~/project-paradise-svc.yaml
echo "Teardown complete"
