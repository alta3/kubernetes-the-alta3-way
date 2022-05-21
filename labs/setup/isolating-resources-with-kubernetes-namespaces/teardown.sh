#!/bin/bash

kubectl delete -f ../yaml/test-rq.yaml --namespace=test
kubectl delete -f ../yaml/dev-rq.yaml --namespace=dev
kubectl delete -f ../yaml/prod-rq.yaml --namespace=prod
kubectl delete -f ../yaml/test-ns.yaml
kubectl delete -f ../yaml/dev-ns.yaml
kubectl delete -f ../yaml/prod-ns.yaml
