### Lab testing

Generate lists of setup directories used by labs

```bash
# within a mdBook, find labs and print their source (between parens)
grep 💻 SUMMARY.md | sed 's/.*(\(.*\))/\1/'

# find setup commands
grep '\`setup' lab-name.md | cut -d '`' -f 4

# get only the setup folder name
grep '\`setup' lab-name.md | cut -d '`' -f 4 | cut -d ' ' -f 2

# all together now
grep 💻 SUMMARY.md | sed 's/.*(\(.*\))/\1/' | xargs -I {} grep "\`setup" {} | cut -d '`' -f 4 | cut -d ' ' -f 2 | xargs -I {} echo -e "setup {}\ntl {}"
```

### Super basic functionality testing (DNS + Network)

```
# run playbook
pushd /home/student/git/kubernetes-the-alta3-way
ansible-playbook main.yml
popd

# setup test network and dns
kubectl delete ns test
kubectl create ns test
kubectl run d1 --image=k8s.gcr.io/e2e-test-images/jessie-dnsutils:1.3 -n test --overrides='{"spec": {"nodeName": "node-1"} }' --command sleep 10000
kubectl run d2 --image=k8s.gcr.io/e2e-test-images/jessie-dnsutils:1.3 -n test --overrides='{"spec": {"nodeName": "node-2"} }' --command sleep 10000
kubectl run c1 --image=busybox -n test --overrides='{"spec": {"nodeName": "node-1"} }' --command sleep 10000
kubectl run c2 --image=busybox -n test --overrides='{"spec": {"nodeName": "node-2"} }' --command sleep 10000
kubectl run --namespace=test nginx --image=nginx
kubectl expose pod nginx --namespace=test --port=80
sleep 60

# test network and dns
kubectl -n test get pods
kubectl exec -n test d1 -- ping -W 1 -c 1 8.8.8.8 | egrep "100% packet loss"
kubectl exec -n test d1 -- ping -W 1 -c 1 10.0.0.1 | egrep "100% packet loss" 
kubectl exec -n test d2 -- ping -W 1 -c 1 8.8.8.8 | egrep "100% packet loss" 
kubectl exec -n test d2 -- ping -W 1 -c 1 10.0.0.1 | egrep "100% packet loss" 
kubectl exec -n test c1 -- wget -T 2 -q nginx -O - | grep Welcome
kubectl exec -n test c2 -- wget -T 2 -q nginx -O - | grep Welcome

# troubleshoot
source <(kubectl completion bash)
kubectl -n kube-system get pods
kubectl describe pods -n kube-system | egrep "^Name:|Node:"

```

```
#!/bin/bash
export COREDNS_POD=$(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name)
kubectl -n kube-system get ${COREDNS_POD} -o=custom-columns=NAME:.metadata.name,NODE:.spec.nodeName
kubectl -n kube-system logs ${COREDNS_POD} | egrep "WARN" # bad
kubectl exec -n test c1 -- wget -T 2 -q nginx -O - | egrep "Welcome" # good
kubectl -n kube-system delete ${COREDNS_POD}
```
