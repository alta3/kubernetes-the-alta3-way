#!/bin/bash
set -euo pipefail

# drill setup tasks go here
ssh node-1 "sudo systemctl start kubelet"

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
