#!/bin/bash
set -euo pipefail

if [ -e ~/gold-bar.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/gold-bar.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-security-contexts.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-security-contexts.yaml

echo "Teardown complete"
