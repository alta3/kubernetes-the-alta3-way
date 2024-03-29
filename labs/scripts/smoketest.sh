#!/bin/bash
set -euxo pipefail

# ***********************************************************
# *Do not modify, this script is generated. See SMOKETEST.md*
# ***********************************************************

{
tl resources-and-scheduling
tl setting-an-applications-resource-requirements
tl cluster-access-with-kubernetes-context
tl hostnames-fqdn-lab
tl understanding-labels-and-selectors
tl autoscaling-challenge
tl expose-service-via-ingress
tl revert-coredns-to-kubedns
tl multi-container-pod-design
tl storage-internal-oot-csi
tl strategies
tl create-and-consume-secrets
tl isolating-resources-with-kubernetes-namespaces
tl deploy-a-networkpolicy
tl writing-a-deployment-manifest
tl exposing-a-service
tl host_networking
tl create-and-configure-a-replicaset
tl listing-resources-with-kubectl-get
tl kubectl-top
tl rolling-updates-and-rollbacks
tl advanced-logging
tl examining-resources-with-kubectl-describe
tl patching
tl install-coredns-lab
tl admission-controller
tl livenessprobes-and-readinessprobes
tl autoscaling
tl taints-and-tolerations
tl create-and-configure-basic-pods
tl horizontal-scaling-with-kubectl-scale
tl init-containers
tl fluentd
tl persistent-configuration-with-configmaps
tl configure-coredns-lab
tl RBAC-authentication-authorization-lab
} | tee $(date -I)_tl.log
