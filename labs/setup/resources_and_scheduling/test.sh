#!/usr/bin/bash

kubectl apply -f ~/mycode/yaml/dev-rq.yaml --namespace=dev
kubectl apply -f ~/mycode/yaml/resourced_deploy.yml
