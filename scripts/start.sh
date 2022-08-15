#!/bin/bash
### Initial parameters to Deploy Infrastructure by CLI and Terraform code
# This script have to run from folder "urban/scripts" only one time for deploy infrustructure in GCP

set -u

### Check start parameters
# Check start folder
CurrentFolderName=$(basename "$PWD")
if [[ "$CurrentFolderName" != "scripts" ]] ; then 
    echo -e "\n=== ERROR. Incorrect started folder!"
    echo -e "Go to 'scripts' folder and run start.sh script again\n"
    exit 1
fi

# Check gcloud connection
gcloud auth list > checkConnection.txt 2>&1
checkConnection=$(cat checkConnection.txt | grep "No credentialed accounts.")
[[ $checkConnection ]] && cat checkConnection.txt \
    && echo -e "\n=== Error: Check gcloud connection.\n" \
    && rm checkConnection.txt && exit 1
rm checkConnection.txt



### Variables
ScriptStarted="$(date +%s)"
export startFolder=$PWD

# Get variables from infr.tfvars and infrustructure/main.tf
export project_id="$(cat ../tf-code/variables/infr.tfvars | grep project_id | awk -F "\"" '{print $2}')"  # project ID
export region="$(cat ../tf-code/variables/infr.tfvars | grep region | awk -F "\"" '{print $2}')"          # backet region
export bucket="$(cat ../tf-code/infrustructure/main.tf | grep bucket | awk -F "\"" '{print $2}')"         # backet
infr_prefix="$(cat ../tf-code/infrustructure/main.tf | grep infrustructure | awk -F "\"" '{print $2}')"   # infrustructure prefix in bucket
deploy_prefix="$(cat ../tf-code/deploy/main.tf | grep deploy | awk -F "\"" '{print $2}')"                 # deploy prefix in bucket

tfvars_infr="../variables/infr.tfvars"      # path to infrustructure tfvars-file
tfvars_deploy="../variables/deploy.tfvars"  # path to deploy tfvars-file


### Initialization
$startFolder/init.sh
exitCode="$?"         # Check exit code
[ $exitCode != 0 ] && echo -e "\n=== ERROR! Check initialization step\n" && exit 1


### Building Infrustructure
# Start Building Infrustructure script
export tfvars=$tfvars_infr
$startFolder/infrustructure.sh
exitCode="$?"              # Check exit code
[ $exitCode != 0 ] && echo "Check initialization step" && exit 1
# Get Variables for GitHub Actions
service_account=$(terraform output -raw service_account_sa_key) # GKE_SA_KEY
cluster_location=$(terraform output -raw cluster_location)      # GKE_ZONE
cluster_name=$(terraform output -raw cluster_name)              # GKE_CLUSTER
# $project_id = GKE_PROJECT


### Deploy in Cluster
# Start Deploy script
export tfvars=$tfvars_deploy
$startFolder/deploy.sh
exitCode="$?"              # Check exit code
[ $exitCode != 0 ] && echo -e "\n=== Check Deploy step\n" && exit 1


### Finish
cd $startFolder
./output.sh

ScriptTakes=$(($(date +%s)-$ScriptStarted))
echo -e "\n###### Finish ###### Job takes $(date -d@$ScriptTakes -u +%M:%S) (min:sec)\n"
