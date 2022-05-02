echo Wreaking Havoc!
echo 32 ac 5b b7 81 2c 9e 8f

#kubectl apply -f faildeploy01.yaml >> /dev/null
kubectl apply -f https://static.alta3.com/files/failpod02.yaml >> /dev/null
rm -- "$0"
echo Good Luck!
