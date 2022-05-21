#!/usr/bin/bash

kubectl config use-context kubernetes-the-alta3-way
kubectl run --port=8888  --image=bchd.registry/alta3-webby webweb
kubectl apply -f ~/mycode/yaml/webweb-deploy.yaml

