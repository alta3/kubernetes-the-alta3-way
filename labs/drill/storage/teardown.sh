#!/bin/bash
set -euo pipefail
if [ -e ~/alta3-pv.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/alta3-pv.yaml
else
  echo "file does not exist"
fi
if [ -e ~/nginx-pvc.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/nginx-pvc.yaml
else
  echo "file does not exist"
fi
if [ -e ~/nginx-with-pv.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/nginx-with-pv.yaml
else
  echo "file does not exist"
fi
set -euo pipefail
echo "Teardown complete"