#!/bin/bash
set -euo pipefail

# drill setup tasks go here
kubectl apply -f https://static.alta3.com/courses/cka/exam/aloha.yml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.2/deploy/static/provider/baremetal/deploy.yaml

echo "[+] Task setup complete! You can now begin. Good luck!"
