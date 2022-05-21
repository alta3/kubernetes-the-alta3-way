#!/usr/bin/bash

kubectl delete pod webweb
kubectl delete -f ~/mycode/yaml/webweb-deploy.yaml

