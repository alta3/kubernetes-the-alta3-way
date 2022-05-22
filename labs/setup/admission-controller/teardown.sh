#!/bin/bash
set -euo pipefail

kubectl delete pod no-lr
kubectl delete --ignore-not-found --wait=false \
  -f ../yaml/lim-ran.yml
