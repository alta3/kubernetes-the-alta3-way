#!/bin/bash
set -euo pipefail

if [ -e ~/nginx-pvc.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/nginx-pvc.yaml
else
  echo "file does not exist"
fi

if [ -e ~/alta3-pv.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/alta3-pv.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-storage-nginx-pvc.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-storage-nginx-pv.yaml

echo "Teardown complete"
