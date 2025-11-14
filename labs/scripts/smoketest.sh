#!/bin/bash
set -euxo pipefail

# ***********************************************************
# *Do not modify, this script is generated. See SMOKETEST.md*
# ***********************************************************

{
tl expose-service-via-ingress
tl isolating-resources-with-kubernetes-namespaces
tl create-and-configure-basic-pods
tl init-containers
tl advanced-logging
tl setting-an-applications-resource-requirements
tl understanding-labels-and-selectors
tl create-and-consume-secrets
tl resources-and-scheduling
tl exposing-a-service
tl revert-coredns-to-kubedns
tl examining-resources-with-kubectl-describe
tl writing-a-deployment-manifest
tl taints-and-tolerations
tl livenessprobes-and-readinessprobes
tl host_networking
tl horizontal-scaling-with-kubectl-scale
tl rolling-updates-and-rollbacks
tl RBAC-authentication-authorization-lab
tl fluentd
tl patching
tl strategies
tl install-coredns-lab
tl deploy-a-networkpolicy
tl cluster-access-with-kubernetes-context
tl hostnames-fqdn-lab
tl persistent-configuration-with-configmaps
tl storage-internal-oot-csi
tl configure-coredns-lab
tl listing-resources-with-kubectl-get
tl autoscaling-challenge
tl kubectl-top
tl multi-container-pod-design
tl autoscaling
tl create-and-configure-a-replicaset
tl admission-controller
} | tee $(date -I)_tl.log
