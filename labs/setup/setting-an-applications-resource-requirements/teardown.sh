#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/linux-pod-r.yaml \
  -f ../yaml/linux-pod-rl.yaml
