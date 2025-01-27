#!/bin/bash
set -euo pipefail

# teardown tasks go here
kubectl delete node node-2

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
