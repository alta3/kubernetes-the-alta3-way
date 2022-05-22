#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found \
  -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
