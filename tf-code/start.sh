# Initial parameters to Deploy Infrastructure by CLI and Terraform code

#!/bin/bash
set -u

### Variables
# Google Bucket
export repo = "ssh..."  #GitHub repo
export bucket="tfstate_files"     # backet
infr_prefix="infrustructure"      # infrustructure prefix in bucket
deploy_prefix="deploy"            # deploy prefix in bucket
export region="us-central1"       # backet region
tfvars_infr="../infr.tfvars"      # path to infrustructure tfvars-file
tfvars_deploy="../deploy.tfvars"  # path to deploy tfvars-file

# Initialization
startFolder=$PWD
./init.sh

# Create infrustructure
cd infrustructure
# Change bucket name and prefix in backend
sed -i "s|tfstate_files|$bucket|g" main.tf
sed -i "s|infrustructure|$infr_prefix|g" main.tf
# Start script
export tfvars=$tfvars_infr
./../infrustructure.sh
# Get Service Account key for GitHub Actions
service_account=$(terraform output -raw service_account_sa_key)

# Deploy in Cluster
cd ../deploy
# Change bucket name and prefix in backend
sed -i "s|tfstate_files|$bucket|g" main.tf
sed -i "s|infrustructure|$deploy_prefix|g" main.tf
# Start script
export tfvars=$tfvars_deploy
./../deploy.sh

# Finish
cd $startFolder
echo -e "\n=== Service Account key for GitHub Actions service_account_key=\n$service_account\n"
echo -e "\n###### Finish ######\n"
