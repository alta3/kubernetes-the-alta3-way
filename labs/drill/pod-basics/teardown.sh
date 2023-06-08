#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-basic-pods.yaml
kubectl delete --ignore-not-found -f ~/singer.yaml
if [ -e ~/singer.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found ~/singer.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
