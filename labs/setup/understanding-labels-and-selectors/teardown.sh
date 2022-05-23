#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/nginx-pod.yaml \
  -f ../yaml/nginx-obj.yaml

kubectl delete --wait="${WAIT}" pods \
  alpaca-prod \
  alpaca-test \
  bandicoot-staging \
  bandicoot-prod
