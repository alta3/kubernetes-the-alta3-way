#!/bin/bash
set -euo pipefail
kubectl apply -f singer.yaml
echo "[-] No teardown"
