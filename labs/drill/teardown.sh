#!/bin/bash
set -euo pipefail

kubectl delete --ignore-not-found pods apricot -n pineapple
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-api-primitives.yaml


kubectl delete --ignore-not-found -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-monitoring.yaml
sleep 60
rm ~/cpu-consume.txt


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-configmaps.yaml
kubectl delete --ignore-not-found -f ~/mycode/yaml/enter-sandman.yaml
kubectl delete --ignore-not-found configmap -n metallica nineteen-eighty-four
kubectl delete --ignore-not-found configmap -n metallica nginx-base-conf


kubectl rollout undo deployment -n king-of-lions mufasa
kubectl delete deploy -n king-of-lions mufasa
kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-busted-deployment.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-deployments.yaml
kubectl delete --ignore-not-found -f ~/manticore-deployment.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-jobs.yaml
kubectl delete --ignore-not-found -f ~/kronos-job.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-logging.yaml
kubectl delete --ignore-not-found -n lincoln vampire-hunter
rm ~/lincoln-logs.txt


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-multi-container-pods.yaml
kubectl delete --ignore-not-found -f snooper-fluentd.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-network-policies.yaml
kubectl delete --ignore-not-found -f ~/cherry-control.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-basic-pods.yaml
kubectl delete --ignore-not-found -f ~/singer.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-probes.yaml
kubectl delete --ignore-not-found -f ~/plumpod.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-secrets.yaml
kubectl delete --ignore-not-found -f ~/juicysecret.yaml
kubectl delete --ignore-not-found -f ~/kiwi-secret-pod.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-security-contexts.yaml
kubectl delete --ignore-not-found -f ~/gold-bar.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-service-accounts.yaml
kubectl delete --ignore-not-found -f ~/banana-deployment.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-services.yaml
kubectl delete --ignore-not-found -f ~/lone-coconut.yaml
kubectl delete --ignore-not-found -f ~/project-paradise-svc.yaml


kubectl delete --ignore-not-found -f ~/alta3-pv.yaml
kubectl delete --ignore-not-found -f ~/nginx-pvc.yaml
kubectl delete --ignore-not-found -f ~/nginx-with-pv.yaml


kubectl delete --ignore-not-found -f ~/mycode/yaml/ctce-drill-debugging.yaml
kubectl delete --ignore-not-found deploy -n upsetti-spaghetti spaghetti-monster


echo "[-] Teardown Complete"
