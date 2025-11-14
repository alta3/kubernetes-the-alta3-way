# First, get the S3 bucket name from the JSON
S3_BUCKET=$(jq -r '.s3_bucket.value' tf_outputs.json)

# Next, CHOOSE the public-facing hostname you will use
MY_HOSTNAME="clearml.ultracoolness.com"

# Now, use a template to create the real values file
cat <<EOF > clearml-values.yaml
# This file was auto-generated

# 1. Use the 'gp3' StorageClass
mongodb:
  persistence:
    storageClass: "gp3"
elasticsearch:
  persistence:
    storageClass: "gp3"
redis:
  master:
    persistence:
      storageClass: "gp3"
  replica:
    persistence:
      storageClass: "gp3"

# 2. Use the S3 bucket from Terraform output
global:
  s3:
    bucket: "${S3_BUCKET}"

# 3. Use the chosen public hostname
apiserver:
  ingress:
    enabled: true
    className: "alb"
    annotations:
      "alb.ingress.kubernetes.io/scheme": "internet-facing"
      "alb.ingress.kubernetes.io/target-type": "ip"
    hosts:
      - host: "${MY_HOSTNAME}"
        paths:
          - path: "/"
            port: 8008

webserver:
  ingress:
    enabled: true
    className: "alb"
    hosts:
      - host: "${MY_HOSTNAME}"
        paths:
          - path: "/"
            port: 8080

fileserver:
  ingress:
    enabled: true
    className: "alb"
    hosts:
      - host: "${MY_HOSTNAME}"
        paths:
          - path: "/"
            port: 8081
EOF
