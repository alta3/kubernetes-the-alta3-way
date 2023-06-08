#!/bin/bash
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-jobs.yaml
if [ -e ~/kronos-job.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/kronos-job.yaml
else
  echo "file does not exist"
fi
echo "Teardown complete"
