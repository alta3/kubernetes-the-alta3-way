#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete pod logger --force --grace-period=0 --ignore-not-found

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
