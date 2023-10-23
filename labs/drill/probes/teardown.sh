#!/bin/bash
set -euo pipefail

if [ -e ~/plumpod.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/plumpod.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-probes.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-probes.yaml

echo "Teardown complete"
