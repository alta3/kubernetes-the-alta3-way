#!/bin/bash
set -euo pipefail
if [ -e ~/lincoln vampire-hunter ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -n ~/lincoln vampire-hunter
else
  echo "file does not exist"
fi
if [ -e ~/lincoln-logs.txt ] 
then
  echo "deleting"
  rm ~/lincoln-logs.txt
else
  echo "file does not exist"
fi
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-logging.yaml
echo "Teardown complete"
