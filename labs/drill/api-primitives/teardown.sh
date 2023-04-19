#!/bin/bash
set -euo pipefail
kubectl delete pods apricot -n pineapple
echo "[-] No teardown"
