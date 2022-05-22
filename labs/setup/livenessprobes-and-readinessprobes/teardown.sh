#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/badpod.yaml \
  -f ../yaml/sise-lp.yaml \
  -f ../yaml/sise-rp.yaml
