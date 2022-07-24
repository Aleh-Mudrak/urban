# Create Infrastructure by CLI and Terraform code

#!/bin/bash
set -u
echo -e "\n###### Create Infrastructure ######\n"

### Variables
# Google Bucket
echo -e "\n=== Initial Parameters:"
echo "tfvars = $tfvars" # path to tfvars-file

### Terraform part
echo -e "\n=== Initialization Terraform'\n"
terraform init
echo -e "\n=== Applaying TF code\n"
terraform apply -var-file $tfvars -auto-approve

# Update the kubectl configuration to use the plugin:
echo -e "\n=== Connecting to Kubernetes Cluster\n"
CLUSTER_NAME=$(terraform output -raw cluster_name)
cluster_location=$(terraform output -raw cluster_location)
gcloud container clusters get-credentials $CLUSTER_NAME --region $cluster_location  # see terraform output - region = us-central1-a
# test connetion
kubectl get nodes
