#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-network-policies.yaml
if [ -e  ~/cherry-control.yaml] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/cherry-control.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
