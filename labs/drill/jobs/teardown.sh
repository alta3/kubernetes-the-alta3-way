#!/bin/bash
set -euo pipefail
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/mycode/yaml/ctce-drill-jobs.yaml
kubectl delete --ignore-not-found --wait="${WAIT}" -f ~/kronos-job.yaml
echo "Teardown complete"
