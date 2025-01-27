#!/bin/bash
set -euo pipefail

# drill setup tasks go here
ssh node-1 "sudo systemctl stop kubelet"

echo "[+] Mischief managed! You can now begin. Good luck!"
