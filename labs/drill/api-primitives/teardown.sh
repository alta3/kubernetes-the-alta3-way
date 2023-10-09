#!/bin/bash
set -euo pipefail
if [ -e ~/apricot.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/apricot.yaml
else
  echo "file does not exist"
fi
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-api-primitives.yaml
kubectl delete --ignore-not-found pods apricot -n pineapple
