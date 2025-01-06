# Kubernetes The Alta3 Way

This repo contains a fully automated installer to deploy a Highly Available Kubernetes cluster using Ansible.  The Kubernetes The Alta3 Way playbook is optimized for learning; with explicit steps and install mechanisms which ensure understanding each task required to bootstrap a production-grade Kubernetes cluster.

Kubernetes The Alta3 Way is used extensively within the student lab environments for Alta3's [Kubernetes Bootcamp](https://alta3.com/overview-kubernetes-ckad) and [Certified Kubernetes Administrator](https://alta3.com/overview-cka-training) courses.  In each course students have access to their own Kubernetes environments capable of demonstrating all of the “K8s” features and components used in CKAD and CKA certifications (Certified Kubernetes Application Developer, Certified Kubernetes Administrator).

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
* gVisor runtime protection on nodes

Components and versions:

```yaml
k8s_version: "1.31.4"        # https://kubernetes.io/releases/#release-v1-31
etcd_version: "3.5.17"       # https://github.com/etcd-io/etcd/releases
cni_version: "1.6.2"         # https://github.com/containernetworking/plugins/releases 
containerd_version: "1.7.24" # https://github.com/containerd/containerd/releases
cri_tools_version: "1.31.1"  # https://github.com/kubernetes-sigs/cri-tools/releases
cfssl_version: "1.6.5"       # https://github.com/cloudflare/cfssl/releases
runc_version: "1.2.2"        # https://github.com/opencontainers/runc/releases
coredns_version: "1.11.12"   # https://github.com/coredns/coredns/releases
calico_version: "3.27.2"     # https://github.com/projectcalico/calico/releases
helm_version: "3.16.3"       # https://github.com/helm/helm/releases
gvisor_version: "latest"     # https://github.com/google/gvisor/releases
```

## Upgrade Schedule

Kubernetes the Alta3 Way aligns its release cycle closely with Kubernetes, adopting a strategic one-version-behind approach to ensure stability and thorough integration with the latest developments.

#### Kubernetes Release Cycle:
- **Frequency:** Kubernetes issues new releases [three times a year](https://kubernetes.io/releases/release/).
- **Support:** The Kubernetes project supports the three most recent minor releases. Detailed information on the release cycle can be found [here](https://kubernetes.io/releases/).

#### Approach:
- **One Version Behind:** To ensure stability and thorough integration, **Kubernetes the Alta3 Way** is maintained one major version behind the latest Kubernetes Upstream Release. This strategy allows for adequate time to manage subcomponent updates and gracefully handle any deprecations.
- **Release Branches:** With each new major release of Kubernetes a corresponding branch is created, named after the version number, dedicated to testing and adaptations.
- **Repository Tags:** Each major release is tagged to facilitate easy access to specific versions.

