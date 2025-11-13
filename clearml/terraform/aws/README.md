Here's a detailed, step-by-step guide for a new user starting this project from a completely blank slate.

This plan assumes they have an AWS account (like your sandbox) and a user login for the web console, but *nothing else*.

-----

## 😴 Sleep-Walkable Guide: ClearML on EKS from Scratch

This guide will walk you through every step, from installing software to deploying the cluster.

### Phase 1: Install Local Software

Before you can build, you need the tools. Install these five applications on your local machine.

1.  **Terraform:** The tool that builds the infrastructure.
      * **Guide:** [https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
2.  **AWS CLI (v2):** The tool for communicating with your AWS account.
      * **Guide:** [https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
3.  **`kubectl`:** The tool for communicating with your Kubernetes cluster (once it's built).
      * **Guide:** [https://kubernetes.io/docs/tasks/tools/install-kubectl/](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
4.  **`helm`:** The package manager for Kubernetes. We use this to install ClearML and the ALB controller.
      * **Guide:** [https://helm.sh/docs/intro/install/](https://helm.sh/docs/intro/install/)
5.  **`jq`:** A command-line tool for processing JSON. This is invaluable for debugging.
      * **Guide:** [https://jqlang.github.io/jq/download/](https://jqlang.github.io/jq/download/)

-----

### Phase 2: One-Time AWS Setup

You only need to do this part once. We'll create the S3 bucket for Terraform's state and the `iac_runner` user that Terraform will use to build everything.

1.  **Log in to your AWS Console** using your normal sandbox admin user.
2.  **Create the S3 State Bucket:**
      * Go to the **S3** service.
      * Click **"Create bucket"**.
      * **Region:** Select `us-east-1` (N. Virginia) *if applicable*
      * **Bucket type:** `General Purpose`
      * **Bucket name:** `alta3-clearml-ie-demo-tfstate`
      * **Object Ownership:** `ACLs disabled (recommended)`
      * **Block all public access:** Keep this **checked**.
      * **Bucket Versioning:** `Disable`
      * **Encryption type:** `Server-side encryption with Amazon S3 managed keys (SSE-S3)`
      * **Bucket Key:** `Enable`      
      * Click **"Create bucket"**.
      * **Important:** Write this bucket name down. You'll need it in a moment.
3.  **Create the `iac_runner` IAM User:**
      * Go to the **IAM** service.
      * Click **"Users"** in the left-hand menu
      * **"Create user"**.
      * **User name:** `iac-runner`
      * Click **Next**.
      * Select **"Attach policies directly"**.
      * In the search box, find and check the box for **`AdministratorAccess`**.
        > **Note:** For a real production setup, you'd create a custom policy with fewer permissions. For a sandbox, `AdministratorAccess` is the simplest way to guarantee it works.
      * Click **Next**, then **"Create user"**.
4.  **Get Your Keys:**
      * You'll be on a confirmation screen. Click the `view user` for the iac-runner user you created.
      * Click the **"Security credentials"** tab.
      * Scroll down to **"Access keys"** and click **"Create access key"**.
      * Select **"Command Line Interface (CLI)"**.
      * Check the "I understand" box and click **Next**.
      * Type in a value like "sean-test-key"
      * Click **"Create access key"**.
      * **THIS IS THE MOST IMPORTANT STEP:** You will see an **Access key ID** and a **Secret access key**. Copy both of these into a secure notepad immediately. You will *never* see the secret key again.
5.  **Configure Your Local AWS CLI:**
      * Open your terminal.
      * Type `aws configure`.
      * It will ask you for four things.
        1.  **AWS Access Key ID:** Paste the Access key ID for `iac-runner`.
        2.  **AWS Secret Access Key:** Paste the Secret access key for `iac-runner`.
        3.  **Default region name:** `us-east-1`
        4.  **Default output format:** `json`

Your local machine is now set up to act as the `iac-runner`.

-----

### Phase 3: Configure Your Terraform Code

Now, we'll edit the project files to match your AWS account.

1.  **Get the Code:** (I'm assuming you have it in a folder named `terraform/`).
2.  **Edit `backend.tf`:**
      * Open the `terraform/backend.tf` file.
      * Change the `bucket` value to the **exact S3 bucket name** you created in Phase 2.
      * **Example:**
        ```hcl
        terraform {
          backend "s3" {
            bucket  = "my-company-clearml-tfstate-20251107" # <-- YOUR BUCKET NAME
            key     = "clearml-eks/terraform.tfstate"
            region  = "us-east-1"
            encrypt = true
          }
        }
        ```
3.  **Edit `variables.tf`:**
      * Open the `terraform/variables.tf` file.
      * **Update your IP Address:** Find the `ssh_cidr` variable.
          * Open a new browser tab and go to [https://ifconfig.me](https://ifconfig.me) to get your public IP.
          * Change the `default` value to `YOUR.IP.ADDRESS/32`.
          * **Example:** If your IP is `203.0.113.10`, it should look like this:
            ```hcl
            variable "ssh_cidr" {
              description = "Your IP for SSH access (e.g., 203.0.113.10/32)"
              type        = string
              default     = "203.0.113.10/32" # <-- YOUR IP
            }
            ```
      * **Update your Kubernetes Version:** Find the `kubernetes_version` variable and set its `default` to your target version (e.g., `"1.32"`).

-----

### Phase 4: Deploy the Cluster

You are now 100% ready. These are the only commands you need to run.

1.  **Open your terminal** and `cd` into the `terraform` directory.
2.  **Initialize Terraform:**
    ```bash
    terraform init
    ```
    This will read your `backend.tf`, connect to your S3 bucket, and download all the providers.
3.  **Apply the Plan:**
    ```bash
    terraform apply
    ```
      * Terraform will show you a huge plan of all the resources it will create.
      * Type `yes` and press Enter.
      * **Go get coffee.** This step will take **15-20 minutes**. This is when the entire EKS cluster, node groups, and all addons are being built.

-----

### Phase 5: Access ClearML

Once the `apply` finishes:

1.  **Configure `kubectl`:**
      * Your `apply` will print an output called `configure_kubectl`. Copy and paste that command into your terminal to connect `kubectl` to your new cluster.
      * `aws eks update-kubeconfig --name clearml-dev --region us-east-1`
2.  **Wait for the Load Balancer:**
      * The `apply` finished, but the AWS Load Balancer takes an **extra 2-5 minutes** to be created.
3.  **Get Your URL:**
      * After 2-5 minutes, run the command from your `get_clearml_web_url` output:
        ```bash
        kubectl get ingress clearml-webserver -n clearml -o jsonpath='{.status.load_balancer.ingress[0].hostname}'
        ```
      * If it returns empty, wait another minute and run it again.
4.  **Log In:**
      * The command will print a long URL like `k8s-clearml-...elb.amazonaws.com`.
      * Paste this into your browser with `http://` at the front to see your ClearML dashboard\!

-----

### Phase 6: Top Troubleshooting Commands

If anything gets stuck, these are your debug tools.

  * `kubectl get nodes`: Are your worker nodes `Ready`?
  * `kubectl get pods -n kube-system -w`: Are the `aws-load-balancer-controller` and `ebs-csi-controller` pods `Running`?
  * `kubectl get pods -n clearml -w`: Are the ClearML pods `Pending` or `Running`?
  * `kubectl describe pod <pod-name> -n <namespace>`: The master command. Use this on any pod that isn't `Running` to see its error messages.

-----

## 📊 Status Report on Our Current `apply`


The `apply` that is running for you *right now* is the first one that has **all the correct code at once**:

1.  This code works to setup pods and get them running, however it doesn't seem to be doing everything we need. Namely setting up the aws_load_balancer. There is code here that is attempting to help, includ the alb_controller file, which is "new" and manually installing the load balancer controller via Helm (bypassing a "addon-not-found" bug we could't get rid of).
2. Right now this results in the following pod situation: 

```
aws-node-4ksgr                        2/2     Running            0              34m
aws-node-pdvl4                        2/2     Running            0              34m
coredns-6b9575c64c-sfv4b              1/1     Running            0              40m
coredns-6b9575c64c-t4wmg              1/1     Running            0              40m
ebs-csi-controller-57c597b6f7-52mtt   1/6     CrashLoopBackOff   55 (26s ago)   34m
ebs-csi-controller-57c597b6f7-677zw   1/6     CrashLoopBackOff   55 (86s ago)   34m
ebs-csi-node-hs9wv                    3/3     Running            0              34m
ebs-csi-node-kgw2z                    3/3     Running            0              34m
kube-proxy-ftpp6                      1/1     Running            0              34m
kube-proxy-kslf4                      1/1     Running            0              34m

```

