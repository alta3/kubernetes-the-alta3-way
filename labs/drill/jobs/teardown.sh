#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-jobs.yaml
kubectl delete --ignore-not-found -f ~/kronos-job.yaml
echo "Teardown complete"
