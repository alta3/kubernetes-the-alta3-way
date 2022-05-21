import os
import ansible_runner

commands= ["sudo docker run -d -p 2345:5000 registry:2",
           "sudo wget https://labs.alta3.com/courses/kubernetes/bchd.registry_hosts -O /etc/hosts",
           "sudo wget https://labs.alta3.com/courses/kubernetes/bchd-reg -O /etc/nginx/sites-enabled/reg",
           "sudo nginx -s reload",
           "sudo wget https://labs.alta3.com/courses/kubernetes/files/containerd_config.toml -O ~/containerd_config.toml",
           "sudo wget https://labs.alta3.com/courses/kubernetes/files/containerd_update.yaml -O ~/containerd_update.yaml",
           "sudo wget https://labs.alta3.com/courses/kubernetes/files/node-hosts.txt -O ~/node-hosts.txt"]

# loop over initial commands
for x in commands:
    print(x)
    result= os.system(x)
    # throw error and exit if any command fails
    if result != 0:
        sys.exit("There was an error in running the initial commands.")

# call playbooks
ansible_runner.run(playbook='/home/student/git/kubernetes-the-alta3-way/main.yml', inventory='/home/student/git/kubernetes-the-alta3-way/hosts.yml')
ansible_runner.run(playbook='/home/student/containerd_update.yaml', inventory='/home/student/node-hosts.txt')