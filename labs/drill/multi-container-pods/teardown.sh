#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-multi-container-pods.yaml
kubectl delete --ignore-not-found -f snooper-fluentd.yaml
echo "Teardown complete"
