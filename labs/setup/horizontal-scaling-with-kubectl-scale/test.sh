#!/usr/bin/bash

kubectl apply -f ../yaml/webby-deploy-filled-out.yaml
kubectl wait --for condition=Available --timeout 5s deployments/webservice
kubectl scale deployment webservice --replicas=1
kubectl wait deployment/webservice --for jsonpath='{.status.readyReplicas}'=1
kubectl get deployment webservice
