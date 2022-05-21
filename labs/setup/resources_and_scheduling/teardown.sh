#!/usr/bin/bash

kubectl delete -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl delete -f ~/mycode/yaml/prod-ns.yaml -f ~/mycode/yaml/test-ns.yaml -f ~/mycode/yaml/dev-ns.yaml
kubectl delete -f ~/mycode/yaml/dev-rq.yaml --namespace=dev
kubectl delete -f ~/mycode/yaml/resourced_deploy.yml
