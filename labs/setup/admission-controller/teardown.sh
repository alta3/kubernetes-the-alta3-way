#!/bin/bash
set -xeuo pipefail

kubectl delete pod no-lr
kubectl delete --ignore-not-found \
  -f ../yaml/lim-ran.yml
