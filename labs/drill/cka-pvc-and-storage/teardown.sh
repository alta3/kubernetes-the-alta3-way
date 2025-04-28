#!/bin/bash
set -euo pipefail

#  find and delete the pod using the PVC bound to rwopv
kubectl delete pod rwopod --force --grace-period=0 --ignore-not-found
# force-delete the PVC bound to rwopv
kubectl delete pvc rwopvc --force --grace-period=0 --ignore-not-found

# force delete the PV named rwopv
# finalizers can block PV deletion. remove them.
if kubectl get pv rwopv &> /dev/null; then
    kubectl patch pv rwopv -p '{"metadata":{"finalizers":[]}}' --type=merge
fi
kubectl delete pv rwopv --force --grace-period=0 --ignore-not-found

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
