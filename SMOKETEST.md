### Deprecations 

```bash
# find any references to deprecated api's
# https://kubernetes.io/docs/reference/using-api/deprecation-guide/
{
  # 1.29
  grep -Ri flowcontrol.apiserver.k8s.io/v1beta2
  # 1.27
  grep -Ri storage.k8s.io/v1beta1
  grep -Ri k8s.gcr.io
  # 1.26
  grep -Ri flowcontrol.apiserver.k8s.io/v1beta1
  grep -Ri autoscaling/v2beta2
  # 1.25
  grep -Ri batch/v1beta1
  grep -Ri discovery.k8s.io/v1beta1
  grep -Ri events.k8s.io/v1beta1
  grep -Ri autoscaling/v2beta1
  grep -Ri policy/v1beta1
  grep -Ri PodSecurityPolicy
  grep -Ri node.k8s.io/v1beta1
}
```

### Basic functionality testing (DNS + Network)

#### run playbook

```
pushd /home/student/git/kubernetes-the-alta3-way
ansible-playbook main.yml
popd
```

#### setup test network and dns

```bash
{ 
  kubectl delete ns test
  kubectl create ns test
  kubectl run d1 --image=registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3 -n test --overrides='{"spec": {"nodeName": "node-1"} }' --command sleep 10000
  kubectl run d2 --image=registry.k8s.io/e2e-test-images/jessie-dnsutils:1.3 -n test --overrides='{"spec": {"nodeName": "node-2"} }' --command sleep 10000
  kubectl run c1 --image=busybox -n test --overrides='{"spec": {"nodeName": "node-1"} }' --command sleep 10000
  kubectl run c2 --image=busybox -n test --overrides='{"spec": {"nodeName": "node-2"} }' --command sleep 10000
  kubectl run --namespace=test nginx --image=nginx
  kubectl expose pod nginx --namespace=test --port=80
  sleep 60
}
```

#### test network and dns

```bash
{
  kubectl -n test get pods
  kubectl exec -n test d1 -- ping -W 1 -c 1 8.8.8.8 | egrep "100% packet loss"
  kubectl exec -n test d1 -- ping -W 1 -c 1 10.0.0.1 | egrep "100% packet loss" 
  kubectl exec -n test d2 -- ping -W 1 -c 1 8.8.8.8 | egrep "100% packet loss" 
  kubectl exec -n test d2 -- ping -W 1 -c 1 10.0.0.1 | egrep "100% packet loss" 
  kubectl exec -n test c1 -- wget -T 2 -q nginx -O - | grep Welcome
  kubectl exec -n test c2 -- wget -T 2 -q nginx -O - | grep Welcome
}
```

#### troubleshoot

```bash
source <(kubectl completion bash)
kubectl -n kube-system get pods
kubectl describe pods -n kube-system | egrep "^Name:|Node:"
```

#### DNS troubleshooting

```bash
#!/bin/bash
export COREDNS_POD=$(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name)
kubectl -n kube-system get ${COREDNS_POD} -o=custom-columns=NAME:.metadata.name,NODE:.spec.nodeName
kubectl -n kube-system logs ${COREDNS_POD} | egrep "WARN" # bad
kubectl exec -n test c1 -- wget -T 2 -q nginx -O - | egrep "Welcome" # good
kubectl -n kube-system delete ${COREDNS_POD}
```

### Lab testing

Generate lists of setup directories used by labs

```bash
# within a mdBook, find labs and print their source (between parens)
# This simply prints the name of the lab markdown file to standard out
# Just to confirm the sed is properly selecting
grep 💻 SUMMARY.md | sed 's/.*(\(.*\))/\1/'

# This will parse a selected lab "lab-name.md" and extract the 'setup' command argument.
# This requires all labs to have a `setup command` within them.
# This step is just a test
grep '\`setup' lab-name.md | cut -d '`' -f 4

# get only the setup folder name
# this step is just a test
grep '\`setup' lab-name.md | cut -d '`' -f 4 | cut -d ' ' -f 2

# Now that we know the above 3 steps work, we can run them all together as follows
# This is the step that does the work
grep 💻 SUMMARY.md | sed 's/.*(\(.*\))/\1/' | xargs -I {} grep "\`setup" {} | cut -d '`' -f 4 | cut -d ' ' -f 2 | shuf - | xargs -I {} echo -e "tl {}"

# Alternate full path if run from (in content)
grep -R "\$\` \`setup" | egrep -v "kubeadm|cka-exam" | cut -d '`' -f 4 | cut -d ' ' -f 2 | shuf - | xargs -I {} echo -e "tl {}"
```

### TODO: Replace the above with a python script derived equivilant that we can cut-paste and just run. 
