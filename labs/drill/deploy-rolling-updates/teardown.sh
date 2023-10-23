#!/bin/bash
set -euo pipefail
if [ -e ~/manticore-deployment.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/manticore-deployment.yaml
else
  echo "file does not exist"
fi
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-deployments.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-deployments.yaml
echo "Teardown complete"
