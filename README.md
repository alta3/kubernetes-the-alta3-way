# Kubernetes The Alta3 Way

This playbook walks you through setting up Kubernetes the Alta3 way. This guide is a fully automated command to bring up a Kubernetes cluster using Ansible.

Kubernetes The Alta3 Way is optimized for learning, which means taking the long route to ensure you understand each task required to bootstrap a Kubernetes cluster.

Kubernetes The Alta3 Way is used extensively within the student lab environments for Alat3's [Kubernetes Bootcamp](https://alta3.com/overview-k8s).  In this course each student has access to their own high availability Kubernetes environment capable of demonstrating all of the “K8s” features and components used in CKAD and CKA certifications (Certified Kubernetes Application Developer, Certified Kubernetes Administrator).

## Copyright

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.

## Target Audience

The target audience for this tutorial is someone planning to support a production Kubernetes cluster and wants to understand how everything fits together.

## Cluster Details

Kubernetes The Alta3 Way guides you through bootstrapping a highly available Kubernetes cluster with:
* A highly available control plane backed by etcd
* End-to-end TLS encryption between components
* RBAC authenticated services and users
* Isolated and default-deny networking

Components and versions:

``` yaml
k8s_version: "1.23.4"       # https://kubernetes.io/releases/#release-v1-23
etcd_version: "3.5.2"       # https://github.com/etcd-io/etcd/releases
cni_version: "1.0.1"        # https://github.com/containernetworking/cni/releases
containerd_version: "1.6.1" # https://github.com/containerd/containerd/releases
cri_tools_version: "1.23.0" # https://github.com/kubernetes-sigs/cri-tools
cfssl_version: "1.6.1"      # https://github.com/cloudflare/cfssl/releases
runc_version: "1.1.0"       # https://github.com/opencontainers/runc/releases
coredns_version: "1.9.0"    # https://github.com/coredns/coredns/releases
calico_version: "3.22.1"    # https://github.com/projectcalico/calico/releases
helm_version: "3.8.0"       # https://github.com/helm/helm/releases
```
