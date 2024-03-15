#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/webby-deploy-filled-out.yaml
