#!/bin/bash
set -euo pipefail

kubectl delete deploy aloha --ignore-not-found
kubectl delete service aloha --ignore-not-found
kubectl delete ingress luau --ignore-not-found

echo "[+] Teardown complete! The task has been reset."
