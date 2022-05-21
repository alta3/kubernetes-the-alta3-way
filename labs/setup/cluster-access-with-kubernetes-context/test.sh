#!/usr/bin/bash

kubectl config use-context kubernetes-the-alta3-way
ls ~/k8s-certs
kubectl config set-context dev-context --namespace=dev
kubectl config use-context dev-context
kubectl config set-context dev-context --namespace=dev --user=admin --cluster=kubernetes-the-alta3-way
kubectl config get-contexts
kubectl config set-context kubernetes-the-alta3-way --namespace=default


