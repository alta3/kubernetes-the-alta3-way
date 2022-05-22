#!/usr/bin/bash

kubectl apply -f ../yaml/sise-deploy.yaml
kubectl wait --for condition=Available --timeout 30s deployments/sise-deploy
kubectl scale deployment sise-deploy --replicas=3
kubectl apply -f ../yaml/webby-deploy.yaml
kubectl wait --for condition=Available --timeout 30s -f deployments/webby-deploy
kubectl get deployment webservice
kubectl get deployment sise-deploy
