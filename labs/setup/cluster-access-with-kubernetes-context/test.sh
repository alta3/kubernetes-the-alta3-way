#!/bin/bash
set -xeuo pipefail

kubectl config use-context kubernetes-the-alta3-way
kubectl config set-context dev-context --namespace=dev
kubectl config use-context dev-context
kubectl config set-context dev-context --namespace=dev --user=admin --cluster=kubernetes-the-alta3-way
kubectl config get-contexts
kubectl config set-context kubernetes-the-alta3-way --namespace=default

# return to default
kubectl config use-context kubernetes-the-alta3-way
