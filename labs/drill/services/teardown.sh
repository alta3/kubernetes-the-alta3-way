#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-services.yaml
if [ -e ~/lone-coconut.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/lone-coconut.yaml
else
  echo "file does not exist"
fi
if [ -e ~/project-paradise-svc.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/project-paradise-svc.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
