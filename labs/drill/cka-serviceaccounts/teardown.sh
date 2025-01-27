#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete clusterrole app-creator --force --grace-period=0
kubectl delete serviceaccount app-dev --force --grace-period=0
kubectl delete clusterrolebinding app-creator-binding --force --grace-period=0

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
