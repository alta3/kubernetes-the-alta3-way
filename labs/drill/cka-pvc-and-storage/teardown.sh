#!/bin/bash
set -euo pipefail

#  find and delete the pod using the PVC bound to rwopv
kubectl delete pod --force --grace-period=0 $(kubectl get pod --all-namespaces -o jsonpath='{range .items[?(@.spec.volumes[?(@.persistentVolumeClaim.claimName=="rwopv")])]}{.metadata.name}{" "}{.metadata.namespace}{"\n"}{end}' | awk '{print $1}') -n $(kubectl get pod --all-namespaces -o jsonpath='{range .items[?(@.spec.volumes[?(@.persistentVolumeClaim.claimName=="rwopv")])]}{.metadata.namespace}{"\n"}{end}' | head -1)

# force-delete the PVC bound to rwopv
kubectl delete pvc --force --grace-period=0 $(kubectl get pvc --all-namespaces --no-headers | awk '/rwopv/ {print $1}')

# force delete the PV named rwopv
# finalizers can block PV deletion. remove them.
kubectl patch pv rwopv -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl delete pv rwopv --force --grace-period=0

echo "[+] Teardown complete! The task has been reset. You can now attempt again."
