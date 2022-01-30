## from `1.18.0` to `1.23.3`

### Updated Versions:

```
k8s_version: "1.23.3"       # https://kubernetes.io/releases/#release-v1-23
etcd_version: "3.5.1"       # https://github.com/etcd-io/etcd/releases/tag/v3.5.1
cni_version: "1.0.1"        # https://github.com/containernetworking/cni/releases/tag/v1.0.1
containerd_version: "1.5.9" # https://github.com/containerd/containerd/releases/tag/v1.5.9
cri_tools_version: "1.23.0" # https://github.com/kubernetes-sigs/cri-tools/releases/tag/v1.23.0
cfssl_version: "1.6.1"      # https://github.com/cloudflare/cfssl/releases/tag/v1.6.1
runc_version: "1.1.0"       # https://github.com/opencontainers/runc/releases/tag/v1.1.0
coredns_version: "1.8.7"    # https://github.com/coredns/coredns/releases/tag/v1.8.7
calico_version: "3.13.1"    # https://github.com/projectcalico/calico/releases/tag/v3.21.4
```

### Removed depricated kube-apiserver flag:

Observed error:
```
kube-apiserver[]: Error: unknown flag: --kubelet-https
```

Fix:
``` diff
# on master kub-apiserver failed with error:
roles/master_install/templates/kube-apiserver.service.j2
-  --kubelet-https=true \
```

### Update kube-scheduler configuration to the latest version

Observed error:
```
# on master kube-scheduler failed with error:
master-1 kube-scheduler[]: E0129 20:41:42.583894   16355 run.go:74] "command failed" err="no kind \"KubeSchedulerConfiguration\" is registered for version \"kubescheduler.config.k8s.io/v1alpha1\" in scheme \"k8s.io/kubernetes/pkg/scheduler/apis/config/scheme/scheme.go:30\""
```

Fix:

``` diff
roles/make_certs/templates/kube-scheduler.yaml.j2
-apiVersion: kubescheduler.config.k8s.io/v1alpha1
+apiVersion: kubescheduler.config.k8s.io/v1beta1
```

### New required service-account flags in kube-apiserver

Observed error:
```
master-1 kube-apiserver[]: E0129 20:48:36.178551   24811 run.go:74] "command failed" err="[service-account-issuer is a required flag, --service-account-signing-key-file and --service-account-issuer are required flags]"

```

`--service-account-signing-key-file string`

> Path to the file that contains the current private key of the service account token issuer. The issuer will sign issued ID tokens with this private key.

`--service-account-issuer strings`

> Identifier of the service account token issuer. The issuer will assert this identifier in "iss" claim of issued tokens. This value is a string or URI. If this option is not a valid URI per the OpenID Discovery 1.0 spec, the ServiceAccountIssuerDiscovery feature will remain disabled, even if the feature gate is set to true. It is highly recommended that this value comply with the OpenID spec: https://openid.net/specs/openid-connect-discovery-1_0.html. In practice, this means that service-account-issuer must be an https URL. It is also highly recommended that this URL be capable of serving OpenID discovery documents at {service-account-issuer}/.well-known/openid-configuration. When this flag is specified multiple times, the first is used to generate tokens and all are used to determine which issuers are accepted.


Fix: 

``` diff
roles/master_install/templates/kube-apiserver.service.j2
-  --service-account-key-file={{ deployed_kube_controller_manager_pem_file }} \
+  --service-account-key-file={{ deployed_service_account_pem_file }} \
+  --service-account-signing-key-file={{ deployed_service_account_key_file }} \
+  --service-account-issuer=https://{{ public_ip }}:6443 \
```

### scheduler configuration update (`v1beta2`)

Observed error:
```
master-1 kube-scheduler[]: E0129 22:46:36.663200   11913 run.go:74] "command failed" err="no kind \"KubeSchedulerConfiguration\" is registered for version \"kubescheduler.config.k8s.io/v1beta1\" in scheme \"k8s.io/kubernetes/pkg/scheduler/apis/config/scheme/scheme.go:30\""
Jan 29 22:46:36 master-1 systemd[1]: kube-scheduler.service: Main process exited, code=exited, status=1/FAILURE
```

Details: https://github.com/kelseyhightower/kubernetes-the-hard-way/issues/687

Fix:

With the latest k8s (1.23.2+) an update to the apiVersion for kubescheduler is required

``` diff
roles/make_certs/templates/kube-scheduler.yaml.j2
-apiVersion: kubescheduler.config.k8s.io/v1beta1
+apiVersion: kubescheduler.config.k8s.io/v1beta2
```

### rbac cluster role aututorization apiVersion update (`v1`)

Observed error:
```
error: unable to recognize rbac-clusterrole.yaml: no matches for kind "ClusterRole" in version "rbac.authorization.k8s.io/v1beta1"
```

Fix:

Kubernetes version `v1.23.1`+ no longer accepts `v1beta` for `rbac.authrization.k8s.io` version.
Update the rbac cluster role authorization configuration yaml to `v1`

``` diff
roles/rbac/files/rbac-clusterrole.yaml
-apiVersion: rbac.authorization.k8s.io/v1beta1
+apiVersion: rbac.authorization.k8s.io/v1
```

### rbac cluster role binding aututorization apiVersion update (`v1`)

Observed error:
```
error: unable to recognize: no matches for kind "ClusterRoleBinding" in version "rbac.authorization.k8s.io/v1beta1"
```

Fix:

Kubernetes version `v1.23.1`+ no longer accepts `v1beta` for `rbac.authrization.k8s.io` version.
Update the rbac cluster role binding authorization configuration yaml to `v1`

``` diff
roles/rbac/files/rbac-clusterrole.yaml
-apiVersion: rbac.authorization.k8s.io/v1beta1
+apiVersion: rbac.authorization.k8s.io/v1
```
