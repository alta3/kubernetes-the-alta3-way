#!/bin/bash
set -euo pipefail

kubectl delete -f https://static.alta3.com/courses/cka/exam/aloha.yml --ignore-not-found --wait
kubectl delete -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/baremetal/deploy.yaml --ignore-not-found --wait
kubectl delete ingress luau --ignore-not-found --wait

echo "[+] Teardown complete! The task has been reset."
