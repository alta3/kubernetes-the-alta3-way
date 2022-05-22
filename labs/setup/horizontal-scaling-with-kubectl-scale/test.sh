#!/usr/bin/bash

kubectl apply -f ../yaml/sise-deploy.yaml
kubectl wait --for condition=Ready --timeout 30s deployment/sise-deploy.yaml
kubectl scale deployment sise-deploy --replicas=3
kubectl wait --for condition=Ready --timeout 30s deployment/sise-deploy
kubectl apply -f ../yaml/webby-deploy.yaml
kubectl wait --for condition=Ready --timeout 30s deployment/webby
kubectl get deployment webservice
kubectl get deployment sise-deploy
