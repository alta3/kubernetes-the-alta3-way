#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/tnt01.yaml \
  -f ../yaml/tnt02.yaml

kubectl taint nodes node-1 trying_taints=yessir:NoSchedule-
