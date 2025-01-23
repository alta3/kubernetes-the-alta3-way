#!/bin/bash
set -euo pipefail

if [ -e ~/crowley.yaml ]
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/crowley.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-daemonsets.yaml
kubectl delete --ignore-not-found -f ~/crowley.yaml

echo "Teardown complete"
