# Urban Task

---

- [Urban Task](#urban-task)
  - [How it use](#how-it-use)
    - [Use Goocle Cloud CLI](#use-goocle-cloud-cli)
    - [Use Terraform code](#use-terraform-code)
    - [Connect to Urban-Cluster](#connect-to-urban-cluster)
    - [GitHub Action](#github-action)
  - [Destroy infrustructure](#destroy-infrustructure)
  - [Requirements](#requirements)
    - [Software Dependencies](#software-dependencies)
      - [Kubectl](#kubectl)
      - [Terraform and Plugins](#terraform-and-plugins)
      - [gcloud](#gcloud)
      - [Enable APIs](#enable-apis)
  - [Homework task for Urban](#homework-task-for-urban)
    - [Requirements](#requirements-1)
    - [What gets evaluated](#what-gets-evaluated)


## How it use

Please review the [Requirements](#requirements) before starting.

* We can use script `DeployInfrustructure.sh` to create Infrustructure.
* Or use the step by step below for Ubuntu 20

### Use Goocle Cloud CLI

* Create/connect in [Google Cloud Console](https://console.cloud.google.com/)
* [Install the gcloud CLI](https://cloud.google.com/sdk/docs/install#deb)

```bash
# install gcloud CLI for Ubuntu
sudo apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli

# Connect with google CLI  
gcloud init
```

* Create [new Project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)

```bash
# Choose dafault Project
gcloud auth application-default login
# Enable the Cloud Storage API:
gcloud services enable storage.googleapis.com

# Create Bucket to save tfstate-files
region="us-central1"
bucket="tfstate_files"
gsutil mb -p taskurban -c REGIONAL -l $region -b on gs://$bucket
```

### Use Terraform code

Variables to create prod Infrastructure in file `prod.tfvars`

```bash
# Clone repository urban-test
git clone ssh ...

# Go to folder `urban-test/tf-code` and run commands:
cd urban-test/tf-code
terraform init
terraform plan -var-file ../prod.tfvars
terraform apply -var-file ../prod.tfvars -auto-approve
```

### Connect to Urban-Cluster

```bash
# Install the gke-gcloud-auth-plugin binary
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin

# Update the kubectl configuration to use the plugin:
CLUSTER_NAME="urban-cluster"
location="us-central1-a"
gcloud container clusters get-credentials $CLUSTER_NAME --region $location  # see terraform output - region = us-central1-a
gcloud container clusters get-credentials $CLUSTER_NAME --zone=$location
# test connetion
kubectl get nodes
```

### GitHub Action

* Requerments to use GitHub Actions
  * Create Secret GCP_SA_KEY

```bash
# Get Service Account key
sa_key=$(terraform output -raw service_account_sa_key)
echo $sa_key
# Copy output and paste in GitHub Secrets GCP-SA-KEY
```



## Destroy infrustructure

If you don't need this infrastructure, you can remove it.

```bash
# Go to folder `urban-test/tf-code` and run commands:
terraform destroy -var-file ../prod.tfvars -auto-approve
 
```

---

## Requirements

* Terraform and kubectl are [installed](#software-dependencies) on the machine where Terraform is executed.
* The Compute Engine and Kubernetes Engine APIs are [active](#enable-apis) on the project you will launch the cluster in.

### Software Dependencies
#### Kubectl
- [kubectl](https://github.com/kubernetes/kubernetes/releases) >= 1.9.x
#### Terraform and Plugins
- [Terraform](https://www.terraform.io/downloads.html)    >= 0.12
- [Terraform Provider for GCP][terraform-provider-google] >= v3.41
#### gcloud
Some submodules use the [terraform-google-gcloud](https://github.com/terraform-google-modules/terraform-google-gcloud) module. By default, this module assumes you already have gcloud installed in your $PATH.
See the [module](https://github.com/terraform-google-modules/terraform-google-gcloud#downloading) documentation for more information.

#### Enable APIs
In order to operate with the Service Account you must activate the following APIs on the project where the Service Account was created:

- Compute Engine API - compute.googleapis.com
- Kubernetes Engine API - container.googleapis.com


---

## Homework task for Urban

The goal of the task is to demonstrate how a candidate can create an environment with terraform. You should commit little and often to show your ways of working

### Requirements

- The environment should get created in Google Cloud Platform
- Create a VPC native Kubernetes cluster
- Host the provided Node.js application provided in the `app` folder in the created cluster with 3 replicas
- Expose the provided application to the public internet
- Include at least 1 custom module in Terraform
- Add the prometheus-client to the provided application and expose one metric on a `/metrics` endpoint
- Write down some thoughts about what compromises you've applied (if any) and how would you like to improve the solution

### What gets evaluated

- Code quality
- Solution architecture
- Whether the code is "production-ready" (i.e. the environment starts and works as expected)


