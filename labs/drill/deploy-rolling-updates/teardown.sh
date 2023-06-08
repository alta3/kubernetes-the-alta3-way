#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-deployments.yaml
if [ -e ~/manticore-deployment.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/manticore-deployment.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
