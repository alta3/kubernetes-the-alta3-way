echo Wreaking Havoc!
echo a9 db 23 a3 2c 9e 8f          

#kubectl apply -f faildeploy01.yaml >> /dev/null  
kubectl apply -f https://static.alta3.com/files/faildeploy01.yaml >> /dev/null 
rm -- "$0"
echo Good Luck!  
