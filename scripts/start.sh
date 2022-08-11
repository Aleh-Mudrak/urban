#!/bin/bash
### Initial parameters to Deploy Infrastructure by CLI and Terraform code
# This script have to run from folder "urban/scripts" only one time for deploy infrustructure in GCP

set -u

### Variables
ScriptStarted="$(date +%s)"
startFolder=$PWD

export project_id="taskurban"     # project ID
export bucket="tfstate_files"     # backet
infr_prefix="infrustructure"      # infrustructure prefix in bucket
deploy_prefix="deploy"            # deploy prefix in bucket
export region="us-central1"       # backet region
tfvars_infr="../infr.tfvars"      # path to infrustructure tfvars-file
tfvars_deploy="../deploy.tfvars"  # path to deploy tfvars-file


### Initialization
$startFolder/init.sh
exitCode="$?"              # Check script status
[ $exitCode != 0 ] && echo "Check initialization step" && exit 1


### Create infrustructure
cd ../tf-code/infrustructure
# Change bucket name and prefix in backend
sed -i "s|taskurban|$project_id|g" $tfvars_infr  # update Project ID in tfvars
sed -i "s|tfstate_files|$bucket|g" main.tf       # update bucket name
sed -i "s|infrustructure|$infr_prefix|g" main.tf # update bucket prefix
# Start script
export tfvars=$tfvars_infr
$startFolder/infrustructure.sh
exitCode="$?"              # Check script status
[ $exitCode != 0 ] && echo "Check initialization step" && exit 1
# Get Variables for GitHub Actions
service_account=$(terraform output -raw service_account_sa_key)  # GKE_SA_KEY
cluster_location=$(terraform output -raw cluster_location)  # GKE_ZONE
cluster_name=$(terraform output -raw cluster_name)  # GKE_CLUSTER
# $project_id = GKE_PROJECT


### Deploy in Cluster
cd ../deploy
# Change bucket name and prefix in backend
sed -i "s|tfstate_files|$bucket|g" $tfvars_deploy   # update bucket in tfvars
sed -i "s|tfstate_files|$bucket|g" main.tf          # update bucket name
sed -i "s|infrustructure|$deploy_prefix|g" main.tf  # update bucket prefix
# Start script
export tfvars=$tfvars_deploy
$startFolder/deploy.sh
exitCode="$?"              # Check script status
[ $exitCode != 0 ] && echo "Check initialization step" && exit 1


### Finish
cd $startFolder
echo -e "\n=== Copy this Variables and past in GitHub Repository Secrets"
echo "GKE_PROJECT = $project_id"
echo "GKE_CLUSTER = $cluster_name"
echo "GKE_ZONE = $cluster_location"
echo "=== GKE_SA_KEY"
echo $service_account
echo -e "\n=== GitHub Secrets link like this:\nhttps://github.com/<Your-Account-Name>/<Your-Repository>/settings/secrets/actions"

ScriptTakes=$(($(date +%s)-$ScriptStarted))
echo -e "\n###### Finish ###### Job takes $(date -d@$ScriptTakes -u +%M:%S) (min:sec)\n"
