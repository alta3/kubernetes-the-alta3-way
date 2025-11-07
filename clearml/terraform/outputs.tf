# MODIFIED: outputs.tf

output "cluster_name" {
  value = module.eks.cluster_name
}

output "get_clearml_web_url" {
  description = "The ClearML URL is not available immediately. Wait ~5 mins, then run this command to get the URL:"
  value       = "kubectl get ingress clearml-webserver -n clearml -o jsonpath='{.status.load_balancer.ingress[0].hostname}'"
}

output "s3_bucket" {
  value = aws_s3_bucket.clearml_artifacts.bucket
}

output "configure_kubectl" {
  value = "aws eks update-kubeconfig --name ${var.cluster_name} --region ${var.aws_region}"
}