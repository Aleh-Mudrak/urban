# Create Bucket for tfstatefile, enable API, clone repo

#!/bin/bash
set -u
echo -e "\n###### Initialization ######\n"

### Variables
echo -e "\n=== Initial Parameters:"
echo "project_id = $project_id" # project ID
echo "bucket = $bucket"         # backet name
echo "region = $region"         # backet region


### Check project_id
CheckProjectID=$(gcloud projects list | grep $project_id | awk '{print $1}')
[[ $CheckProjectID != $project_id ]] && \
    echo -e "\n=== Error: Your Google account don't have project_id=$project_id" && \
    echo -e "Create project with project_id=$project_id in your account" && \
    echo -e "or chenge project_id in file tf-code/variables/infr.tfvars \n" && \
    exit 1


### Google Cloud
echo -e "\n=== Prepare Application and API"
# Choose dafault Project
gcloud config set project $project_id
# Enable the Cloud Storage APs:
gcloud services enable storage.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
# gcloud services enable artifactregistry.googleapis.com


### Creating Bucket
gsutil ls gs://$bucket > checkConnection.txt 2>&1
if [[ $(cat checkConnection.txt | grep "BucketNotFoundException") ]] ; then 
    # BucketNotFoundException: 404 gs://tfstate_files1 bucket does not exist.
    echo -e "\n=== Creating Bucket to save tfstate-files\n"
    gsutil mb -p $project_id -c REGIONAL -l $region -b on gs://$bucket
elif [[ $(cat checkConnection.txt | grep "//$bucket/") ]] ; then 
    echo -e "Bucket $bucket exist"
else
    # AccessDeniedException: 403 YourAccount@gmail.com does not have storage.objects.list access to the Google Cloud Storage bucket.
    echo && cat checkConnection.txt
    echo -e "\n=== Error: Your Backet Name exist or you have another problem."
    rm checkConnection.txt
    exit 1
fi
rm checkConnection.txt
