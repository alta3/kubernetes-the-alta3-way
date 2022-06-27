kubectl delete cm --all

wget https://static.alta3.com/projects/k8s/nginx.conf.final -O ~/nginx.conf
wget https://static.alta3.com/projects/k8s/index.html2 -O ~/index.html
echo "It was a bright cold day in April, and the clocks were striking thirteen." > nginx.txt

kubectl create configmap nginx-txt --from-file=nginx.txt
kubectl create configmap nginx-conf --from-file=nginx.conf
kubectl create configmap index-file --from-file=index.html