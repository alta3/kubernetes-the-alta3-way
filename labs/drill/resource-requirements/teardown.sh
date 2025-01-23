#!/bin/bash
set -euo pipefail

if [ -e ~/zerotohero.yaml ]
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/zerotohero.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-resource-requirements.yaml
kubectl delete --ignore-not-found -f ~/zerotohero.yaml

echo "Teardown complete"
