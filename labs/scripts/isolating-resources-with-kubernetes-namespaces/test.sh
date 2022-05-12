#!/usr/bin/bash

kubectl apply -f ~/mycode/yaml/test-ns.yaml
kubectl apply -f ~/mycode/yaml/dev-ns.yaml
kubectl apply -f ~/mycode/yaml/prod-ns.yaml
kubectl apply -f ~/mycode/yaml/test-rq.yaml --namespace=test
kubectl apply -f ~/mycode/yaml/prod-rq.yaml --namespace=prod
kubectl apply -f ~/mycode/yaml/prod-rq.yaml --namespace=prod
kubectl delete -f ~/mycode/yaml/test-rq.yaml --namespace=test
kubectl delete -f ~/mycode/yaml/dev-rq.yaml --namespace=dev
kubectl delete -f ~/mycode/yaml/prod-rq.yaml --namespace=prod
