# Deploy in Cluster by Terraform code

#!/bin/bash
set -u
echo -e "\n###### Deploy in Cluster ######\n"
cd ../tf-code/deploy

### Variables
# Google Bucket
echo -e "\n=== Initial Parameters:"
echo "tfvars = $tfvars" # path to tfvars-file

### Terraform part
echo -e "\n=== Initialization Terraform'\n"
terraform init
echo -e "\n=== Applaying TF code\n"
terraform apply -var-file $tfvars -auto-approve
