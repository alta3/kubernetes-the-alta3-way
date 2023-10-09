#!/bin/bash
set -euo pipefail

if [ -e ~/project-paradise-svc.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/project-paradise-svc.yaml
else
  echo "file does not exist"
fi

if [ -e ~/lone-coconut.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/lone-coconut.yaml
else
  echo "file does not exist"
fi

kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-services.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-project-paradise-svc.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-lone-coconut.yaml

echo "Teardown complete"
