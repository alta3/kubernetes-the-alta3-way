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
coredns_version: "1.9.0"    # https://github.com/coredns/coredns/releases/tag/v1.9.0
calico_version: "3.21.4"    # https://github.com/projectcalico/calico/releases/tag/v3.21.4
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


## unsolved errors

```
[INFO] plugin/ready: Still waiting on: "kubernetes"

W0130 reflector.go:324 pkg/mod/k8s.io/client-go@v0.23.1/tools/cache/reflector.go:167: failed to list *v1.EndpointSlice: endpointslices.discovery.k8s.io is forbidden: User "system:serviceaccount:kube-system:coredns" cannot list resource "endpointslices" in API group "discovery.k8s.io" at the cluster scope
E0130 reflector.go:138 pkg/mod/k8s.io/client-go@v0.23.1/tools/cache/reflector.go:167: Failed to watch *v1.EndpointSlice: failed to list *v1.EndpointSlice: endpointslices.discovery.k8s.io is forbidden: User "system:serviceaccount:kube-system:coredns" cannot list resource "endpointslices" in API group "discovery.k8s.io" at the cluster scope
```

```
master-1 kube-apiserver[]: E0130 authentication.go:63] "Unable to authenticate the request" err="invalid bearer token"
```

```
[WARNING][60] active_rules_calculator.go 326: Profile not known or invalid, generating dummy profile that drops all traffic. profileID="ksa.kube-system.coredns"

```
```
node-1 kubelet[]: E0130 driver-call.go:262] Failed to unmarshal output for command: init, output: "", error: unexpected end of JSON input
node-1 kubelet[]: W0130 driver-call.go:149] FlexVolume: driver call failed: executable: /usr/libexec/kubernetes/kubelet-plugins/volume/exec/nodeagent~uds/uds, args: [init], error: fork/exec /usr/libexec/kubernetes/kubelet-plugins/volume/exec/nodeagent~uds/uds: no such file or directory, output: ""
node-1 kubelet[]: E0130 plugins.go:752] "Error dynamically probing plugins" err="error creating Flexvolume plugin from directory nodeagent~uds, skipping. Error: unexpected end of JSON input"
```

```
[INFO][1] main.go 94: Loaded configuration from environment config=&config.Config{LogLevel:"info", WorkloadEndpointWorkers:1, ProfileWorkers:1, PolicyWorkers:1, NodeWorkers:1, Kubeconfig:"", DatastoreType:"etcdv3"}
[FATAL][1] main.go 107: Failed to start error=failed to build Calico client: could not initialize etcdv3 client: open /calico-secrets/etcd-cert: permission denied
```

### Avoid deleting all of `/bin` with unarchive

New in python3.8 ansible version 2.12 the unarchive module will happily delete (overwrite by removal)
existing directories.  This can be bad when we're extracting the containerd tar ball onto `/bin`

Normal tar execution doesn't delete the source directory
```
cd /
tar xvfz containerd-1.5.9-linux-amd64.tar.gz
bin/
bin/ctr
bin/containerd-shim-runc-v2
bin/containerd-shim-runc-v1
bin/containerd-shim
bin/containerd
```

Ansible says hold my beer

```
student@node-2:~$ ls -al /bin
total 98372
drwxr-xr-x  2 student admin     4096 Jan  5 17:35 .
drwxr-xr-x 20 root    root      4096 Jan 30 19:45 ..
-rwxr-xr-x  1 student admin 49259008 Jan  5 17:35 containerd
-rwxr-xr-x  1 student admin  6438912 Jan  5 17:35 containerd-shim
-rwxr-xr-x  1 student admin  8777728 Jan  5 17:35 containerd-shim-runc-v1
-rwxr-xr-x  1 student admin  8794112 Jan  5 17:35 containerd-shim-runc-v2
-rwxr-xr-x  1 student admin 27448416 Jan  5 17:35 ctr
```

Fix: 

```
+   extra_opts: ["--strip-components=1"]
```

### CoreDNS starts unsync'd

```
[WARNING] plugin/kubernetes: starting server with unsynced Kubernetes API
```


### Network setup failure on pods


``` log
  Warning  FailedCreatePodSandBox  3m34s                kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "e647c56fc036f1926ccb665873b3653cde5cd6510bb17c649f05efd250cec12c": Unauthorized
  Warning  FailedCreatePodSandBox  3m18s                kubelet            (combined from similar events): Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "da0bb6e5252f0d848ac32811ee027db0af9f71c27a5ac7e192a4d05cc4599edf": Unauthorized
```


``` log
2022-01-30 17:21:57.754 [ERROR][26729] plugin.go 121: Final result of CNI ADD was an error. error=Unauthorized
2022-01-30 17:21:57.914 [WARNING][26747] k8s.go 521: WorkloadEndpoint does not exist in the datastore, moving forward with the clean up ContainerID="da0bb6e5252f0d848ac32811ee027db0af9f71c27a5ac7e192a4d05cc4599edf" WorkloadEndpoint="node--3-k8s-coredns--66d5dc5c47--bl67p-eth0"
2022-01-30 17:21:58.017 [WARNING][26775] ipam_plugin.go 432: Asked to release address but it doesn't exist. Ignoring ContainerID="da0bb6e5252f0d848ac32811ee027db0af9f71c27a5ac7e192a4d05cc4599edf" HandleID="k8s-pod-network.da0bb6e5252f0d848ac32811ee027db0af9f71c27a5ac7e192a4d05cc4599edf" Workload="node--3-k8s-coredns--66d5dc5c47--bl67p-eth0"
```

https://projectcalico.docs.tigera.io/reference/resources/workloadendpoint



```
sudo journalctl -n 2000 -f | egrep -v "sudo|pam|sshd|systemd-logind|ansible|systemd\[1\]"
```

# s/master/controller/g
https://github.com/kubernetes/website/issues/6525

cannot change:
```
roles/calico/templates/calico.yaml.j2:        - key: node-role.kubernetes.io/master
roles/make_certs/templates/admin-csr.json.j2:      "O": "system:masters",
```



## verify

```
curl --cacert ~/k8s-certs/ca.pem https://127.0.0.1:6443/version
source <(kubectl completion bash)
kubectl get nodes
kubectl get pods --all-namespaces

# test dns
# https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
kubectl exec -i -t dnsutils -- nslookup kubernetes.default


kubectl create deployment nginx1 --image=nginx
kubectl create deployment nginx2 --image=nginx
kubectl create deployment nginx3 --image=nginx
kubectl create deployment nginx4 --image=nginx
kubectl create deployment nginx5 --image=nginx
sleep 30
kubectl get pods -l app=nginx2
kubectl exec --stdin --tty nginx- -- /bin/bash

kubectl delete deployment nginx1 
kubectl delete deployment nginx2 
kubectl delete deployment nginx3 
kubectl delete deployment nginx4 
kubectl delete deployment nginx5 


```
