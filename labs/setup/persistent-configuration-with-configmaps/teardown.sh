#!/bin/bash
set -euo pipefail

kubectl delete configmap nginx-base-conf
kubectl delete configmap index-html-zork
kubectl delete configmap nineteen-eighty-four
kubectl delete pod nginx-configured
