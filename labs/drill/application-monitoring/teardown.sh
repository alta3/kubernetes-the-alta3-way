#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-monitoring.yaml
sleep 60
rm ~/cpu-consume.txt
echo "Teardown complete"
