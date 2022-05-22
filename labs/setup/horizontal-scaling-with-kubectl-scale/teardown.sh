#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/sise-deploy.yaml \
  -f ../yaml/webby-deploy.yaml
