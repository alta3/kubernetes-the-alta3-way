#!/usr/bin/bash

kubectl delete -f ~/mycode/yaml/test-ns.yaml
kubectl delete -f ~/mycode/yaml/dev-ns.yaml
kubectl delete -f ~/mycode/yaml/prod-ns.yaml
kubectl delete -f ~/mycode/yaml/test-rq.yaml --namespace=test
kubectl delete -f ~/mycode/yaml/dev-rq.yaml --namespace=dev
kubectl delete -f ~/mycode/yaml/prod-rq.yaml --namespace=prod
