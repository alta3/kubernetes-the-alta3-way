#!/bin/bash
set -euo pipefail

PV_NAME="rompv"

# Force delete the PV and suppress output
kubectl delete pv "$PV_NAME" --force --grace-period=0 --ignore-not-found &> /dev/null

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
