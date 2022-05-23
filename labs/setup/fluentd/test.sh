#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/fluentd-conf.yaml 
kubectl apply -f ../yaml/fluentd-pod.yaml
kubectl wait --for condition=Ready --timeout 30s pod/logger
BCHD_IP=$(hostname -f) j2 ../yaml/http_fluentd_config.yaml | kubectl apply -f - 
kubectl apply -f ../yaml/http_fluentd.yaml 
kubectl wait --for condition=Ready --timeout 30s pod/http-logger
kubectl get pods

# TODO test recieving logs

