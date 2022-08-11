# Create Bucket for tfstatefile, enable API, clone repo

#!/bin/bash
set -u
echo -e "\n###### Initialization ######\n"

### Variables
echo -e "\n=== Initial Parameters:"
echo "project_id = $project_id" # project ID
echo "bucket = $bucket"         # backet name
echo "region = $region"         # backet region


### Google Cloud
echo -e "\n=== Prepare Application and API"
# Choose dafault Project
gcloud config set project $project_id
# Enable the Cloud Storage APs:
gcloud services enable storage.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable container.googleapis.com
# gcloud services enable artifactregistry.googleapis.com


# Create Bucket to save tfstate-files
echo -e "\n=== Creating Bucket to save tfstate-files\n"
gsutil mb -p taskurban -c REGIONAL -l $region -b on gs://$bucket
### !!! Add - check $bucket exist and this Project or no

