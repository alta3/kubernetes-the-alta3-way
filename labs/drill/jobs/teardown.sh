#!/bin/bash
set -euo pipefail
if [ -e ~/kronos-job.yaml ] 
then
  echo "deleting"
  kubectl delete --ignore-not-found -f ~/kronos-job.yaml
else
  echo "file does not exist"
fi
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-jobs.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-answers-cronjob-solution.yaml
echo "Teardown complete"
