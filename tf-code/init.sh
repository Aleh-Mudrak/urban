# Create Bucket for tfstatefile, enable API, clone repo

#!/bin/bash
set -u
echo -e "\n###### Initialization ######\n"

### Variables
echo -e "\n=== Initial Parameters:"
echo "bucket = $bucket"    # backet name
echo "region = $region"    # backet region


### Google Cloud
echo -e "\n=== Prepare Application and API"
# Choose dafault Project
gcloud auth application-default login
# Enable the Cloud Storage API:
gcloud services enable storage.googleapis.com
# Install the gke-gcloud-auth-plugin binary
# echo -e "\n=== Installing google-cloud-sdk-gke-gcloud-auth-plugin with root access..."
# sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

# Create Bucket to save tfstate-files
echo -e "\n=== Creating Bucket to save tfstate-files\n"
gsutil mb -p taskurban -c REGIONAL -l $region -b on gs://$bucket
