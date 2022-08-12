# Create Infrastructure by CLI and Terraform code

#!/bin/bash
set -u
echo -e "\n###### Create Infrastructure ######\n"
cd ../tf-code/infrustructure

### Variables
# Google Bucket
echo -e "\n=== Initial Parameters:"
echo "tfvars = $tfvars" # path to tfvars-file

### Terraform part
echo -e "\n=== Initialization Terraform'\n"
terraform init
echo -e "\n=== Applying TF code\n"
terraform apply -var-file $tfvars -auto-approve
# Check terraform apply
exitCode="$?"
[ $exitCode != 0 ] && \
    echo -e "\n=== ERROR! Infrustructure deploy by Terraform has problem\n" && \
    exit 1


# Update the kubectl configuration to use the plugin:
echo -e "\n=== Connecting to Kubernetes Cluster\n"
CLUSTER_NAME=$(terraform output -raw cluster_name)
cluster_location=$(terraform output -raw cluster_location)
gcloud container clusters get-credentials $CLUSTER_NAME --region $cluster_location
# test connetion to Cluster
exitCode="$?"
[ $exitCode != 0 ] && \
    echo -e "\n=== ERROR! Problems Connecting to the Cluster\n" && \
    exit 1
kubectl get nodes
