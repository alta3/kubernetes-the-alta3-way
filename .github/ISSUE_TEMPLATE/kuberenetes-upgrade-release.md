---
name: kuberenetes upgrade release
about: 'This is when upgrading k8s-the-alta3-way quarterly releases. '
title: 'Upgrade Kubernetes to #.##'
labels: "Difficulty: \U0001F7E6, Priority: Medium, Type: Maintenance"
assignees: seaneon
type: Task

---

# Kubernetes v1.35.3: Timbernetes

<img src="https://kubernetes.io/blog/2025/12/17/kubernetes-v1-35-release/k8s-v1.35.png" width="400" height="400"/>



#### EXAMPLES BELOW: THESE EXACT LINKS WILL CHANGE and THE ENTIRE URL COULD CHANGE AT ANY POINT
- https://github.com/kubernetes/kubernetes/releases/tag/v1.31.4
- https://kubernetes.io/blog/2024/08/13/kubernetes-v1-31-release/
- https://kubernetes.io/docs/reference/using-api/deprecation-guide/#v1-31

## Supporting component releases

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
