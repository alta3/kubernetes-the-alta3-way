#!/bin/bash
set -xeuo pipefail

kubectl apply -f ../yaml/dev-rq.yaml --namespace=dev
kubectl apply -f ../yaml/resourced_deploy.yml
kubectl wait --for condition=Available --timeout 60s --namespace=dev deployments.apps/resourced-deploy
kubectl get -f ../yaml/resourced_deploy.yml
