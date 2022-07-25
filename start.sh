# Initial parameters to Deploy Infrastructure by CLI and Terraform code

#!/bin/bash
set -u

ScriptStarted="$(date +%s)"
### Variables
export project_id="taskurban2"       # project ID
export bucket="my_tfstate_files"     # backet
infr_prefix="my_infrustructure"      # infrustructure prefix in bucket
deploy_prefix="my_deploy"            # deploy prefix in bucket
export region="us-central1"       # backet region
tfvars_infr="../infr.tfvars"      # path to infrustructure tfvars-file
tfvars_deploy="../deploy.tfvars"  # path to deploy tfvars-file

# Initialization
startFolder=$PWD
cd tf-code/
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
echo -e "\n=== Copy this Service Account key for GitHub Actions.KE_SA_KEY="
echo -n $service_account
echo -e "\n=== Paste the Key KE_SA_KEY in your GH Secret like this link:\nhttps://github.com/Aleh-Mudrak/urban/settings/secrets/actions"

ScriptTakes=$(($(date +%s)-$ScriptStarted))
echo "Job takes $(date -d@$ScriptTakes -u +%M:%S) (min:sec)"
echo -e "\n###### Finish ######\n"
