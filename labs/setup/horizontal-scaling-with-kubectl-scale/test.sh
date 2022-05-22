#!/usr/bin/bash

kubectl apply -f ../yaml/sise-deploy.yaml
kubectl wait --for condition=Ready --timeout 30s -f ../yaml/sise-deploy.yaml
kubectl scale deployment sise-deploy --replicas=3
kubectl apply -f ../yaml/webby-deploy.yaml
kubectl wait --for condition=Ready --timeout 30s -f ../yaml/webby-deploy.yaml
kubectl get deployment webservice
kubectl get deployment sise-deploy
