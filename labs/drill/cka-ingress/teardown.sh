#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete -f https://static.alta3.com/courses/cka/exam/aloha.yml --force --grace-period=0 --ignore-not-found
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/baremetal/deploy.yaml --force --grace-period=0 --ignore-not-found
kubectl delete ingress luau --force --grace-period=0 --ignore-not-found

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
