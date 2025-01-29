#!/bin/bash
set -euo pipefail

if [ -e ~/crowley.yaml ]
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/crowley.yaml --force --grace-period=0
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-daemonsets.yaml --force --grace-period=0
kubectl delete --ignore-not-found -f ~/crowley.yaml --force --grace-period=0

echo "Teardown complete"
