#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/prod-ns.yaml \
  -f ../yaml/test-ns.yaml \
  -f ../yaml/dev-ns.yaml
