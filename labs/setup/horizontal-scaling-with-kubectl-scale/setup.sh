#!/usr/bin/bash

kubectl apply -f ../yaml/sise-deploy.yaml
kubectl wait --for condition=Ready --timeout 30s deployment/sise-deploy.yaml
kubectl scale deployment sise-deploy --replicas=3
kubectl wait --for condition=Ready --timeout 30s deployment/sise-deploy.yaml
kubectl apply -f ../yaml/webby-deploy.yaml
kubectl wait --for condition=Ready --timeout 30s deployment/webby-deploy.yaml
kubectl get -f ../yaml/webby-deploy.yaml
kubectl get -f ../yaml/sise-deploy.yaml
