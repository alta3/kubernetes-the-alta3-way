# Kubernetes The Alta3 Way

This repo contains a fully automated installer to deploy a Highly Available Kubernetes cluster using Ansible.  The Kubernetes The Alta3 Way playbook is optimized for learning; with explict steps and install mechanisms which ensure understanding each task required to bootstrap a production-grade Kubernetes cluster.

Kubernetes The Alta3 Way is used extensively within the student lab environments for Alat3's [Kubernetes Bootcamp](https://alta3.com/overview-kubernetes-ckad) and [Certified Kubernetes Administrator](https://alta3.com/overview-cka-training) courses.  In each course students have access to their own Kubernetes environments capable of demonstrating all of the “K8s” features and components used in CKAD and CKA certifications (Certified Kubernetes Application Developer, Certified Kubernetes Administrator).

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

```yaml
k8s_version: "1.25.5"        # https://kubernetes.io/releases/#release-v1-25
etcd_version: "3.5.6"        # https://github.com/etcd-io/etcd/releases
cni_version: "1.1.2"         # https://github.com/containernetworking/cni/releases
containerd_version: "1.6.12" # https://github.com/containerd/containerd/releases
cri_tools_version: "1.25.0"  # https://github.com/kubernetes-sigs/cri-tools/releases
cfssl_version: "1.6.3"       # https://github.com/cloudflare/cfssl/releases
runc_version: "1.1.4"        # https://github.com/opencontainers/runc/releases
coredns_version: "1.10.0"    # https://github.com/coredns/coredns/releases
calico_version: "3.24.5"     # https://github.com/projectcalico/calico/releases
helm_version: "3.10.2"       # https://github.com/helm/helm/releases
```
