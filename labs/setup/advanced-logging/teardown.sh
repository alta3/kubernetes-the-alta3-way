#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/counter-pod.yaml \
  -f ../yaml/two-pack.yaml \
  -f ../yaml/nginx-rsyslog-pod.yaml \
