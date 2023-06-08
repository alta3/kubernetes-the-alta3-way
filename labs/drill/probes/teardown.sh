#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-probes.yaml
if [ -e ~/plumpod.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/plumpod.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
