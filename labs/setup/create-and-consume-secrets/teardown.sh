#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait=false -f ../yaml/mysql-secret.yaml
kubectl delete --ignore-not-found --wait=false -f ../yaml/mysql-locked.yaml
