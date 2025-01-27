#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete pod noded --force --grace-period=0

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
