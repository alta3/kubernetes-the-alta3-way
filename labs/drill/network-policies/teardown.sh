#!/bin/bash
set -euo pipefail

if [ -e  ~/cherry-control.yaml] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/cherry-control.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-network-policies.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-network-policies.yaml

echo "Teardown complete"
