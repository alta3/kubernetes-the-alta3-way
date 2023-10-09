#!/bin/bash
set -euo pipefail

if [ -e ~/singer.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/singer.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-basic-pods.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-basic-pods.yaml
kubectl delete --ignore-not-found -f ~/singer.yaml

echo "Teardown complete"
