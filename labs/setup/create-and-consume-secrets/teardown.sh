#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/mysql-secret.yaml \
  -f ../yaml/mysql-locked.yaml \
