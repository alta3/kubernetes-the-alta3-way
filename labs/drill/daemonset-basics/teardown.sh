#!/bin/bash
set -euo pipefail

kubectl delete -n goodomens daemonset crowley --ignore-not-found --force --grace-period=0
kubectl delete ns goodomens --ignore-not-found

echo "Teardown complete"
