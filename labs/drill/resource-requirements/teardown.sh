#!/bin/bash
set -euo pipefail


kubectl delete pod zerotohero -n hercules --ignore-not-found --force --grace-period=0
kubectl delete ns hercules --ignore-not-found

echo "Teardown complete"
