q1 = """
1. What are the architectural components of a Kubernetes cluster?

    - A. Docker Containers, Virtual Machines
    - B. Master Nodes, Worker Nodes
    - C. Docker Containers, Worker Nodes
    - D. Master Nodes, Virtual Machines
"""

q2 = """
2. What is the name of the file which holds resource definitions? *Hint: A Pod _____ or a Deployment ______*

    - A. Order
    - B. Outline
    - C. Recipe
    - D. Manifest
"""

q3 = """
3. What database does Kubernetes use to store cluster state?

    - A. MySQL
    - B. Postgres
    - C. etcd
    - D. Mongo
"""

q4 = """
4. A basic Pod must have which of these items defined? 

    - A. Nodes
    - B. Deployments
    - C. ReplicaSets
    - D. Containers
"""

q5 = """
5. Generally, specifications about cluster resources are written in _____?

    - A. YAML
    - B. HTML
    - C. JSON
    - D. XML
"""

q6 = """
6. True or False: A Pod splits work intelligently by separating containers across multiple nodes.

    - A. True
    - B. False
"""

q7 = """
7. Which service allows a user to request new resources be built inside of the Kubernetes cluster?

    - A. kubectl
    - B. kubelet
    - C. etcd
    - D. kubeadm
"""

q8 = """
8. Deployments are wrappers around:

    - A. Applications
    - B. Pods
    - C. ReplicaSets
    - D. Secrets
"""

q9 = """
9. PersistentVolumeClaims bind what resource to a PersistentVolume?

    - A. Pod
    - B. Service
    - C. Deployment
    - D. ConfigMap
"""

q10 = """
10. Which of the following are you able to define for a particular container?

    - A. nodeName and volumes
    - B. selector and template
    - C. requests and limits
    - D. apiVersion and kind
"""

def main():
    questions = [q1, q2, q3, q4, q5, q6, q7, q8, q9, q10]
    answers = [input(q) for q in questions]
    correct_answers = ["B", "D", "C", "D", "A", "B", "A", "C", "A", "C"]
    points = 0
    for ind, answer in enumerate(answers):
        if answer.upper() == correct_answers[ind]:
            points += 1
    response = zip(answers, correct_answers)
    data = {"score": points, "answers": response}
    return data
    
    
if __name__ == "__main__":
    print("\n\nBeginning Your Kubernetes Proficiency Test\n")
    grade = main()
    print(f"You received a {grade['score']}/10!\nYour Answer, Correct Answer\n")
    for answer in grade['answers']:
        print(f"     {answer[0]}           {answer[1]}")
     
