#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found --wait="${WAIT}" \
  -f ../yaml/fluentd-conf.yaml \
  -f ../yaml/fluentd-pod.yaml \
  -f ../yaml/http_fluentd_config.yaml \
  -f ../yaml/http_fluentd.yaml 
