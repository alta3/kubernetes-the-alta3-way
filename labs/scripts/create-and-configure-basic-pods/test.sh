#!/usr/bin/bash

kubectl config use-context kubernetes-the-alta3-way
kubectl create -f ~/mycode/yaml/simpleservice.yaml
kubectl apply -f ~/mycode/yaml/webby-pod01.yaml
sleep 35
kubectl get pods
kubectl delete -f ~/mycode/yaml/simpleservice.yaml
kubectl delete -f ~/mycode/yaml/webby-pod01.yaml

