#!/bin/bash
### Output GHA Secrets

set -u

startFolder=$PWD
project_id="$(cat ../tf-code/variables/infr.tfvars | grep project_id | awk -F "\"" '{print $2}')"  # project ID

cd ../tf-code/infrustructure
service_account=$(terraform output -raw service_account_sa_key) # GKE_SA_KEY
cluster_location=$(terraform output -raw cluster_location)      # GKE_ZONE
cluster_name=$(terraform output -raw cluster_name)              # GKE_CLUSTER

### Output
cd $startFolder
echo -e "\n=== Copy this Variables and past in GitHub Repository Secrets"
echo "GKE_PROJECT = $project_id"
echo "GKE_CLUSTER = $cluster_name"
echo "GKE_ZONE = $cluster_location"
echo "=== GKE_SA_KEY"
echo $service_account
echo -e "\n=== GitHub Secrets link like this:\nhttps://github.com/<Your-Account-Name>/<Your-Repository>/settings/secrets/actions"
