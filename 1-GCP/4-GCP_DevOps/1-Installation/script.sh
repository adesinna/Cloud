#!/bin/bash

# Update the package list
sudo apt-get update -y

# Install required packages for adding a new repository
sudo apt-get install apt-transport-https ca-certificates gnupg -y

# Add the Google Cloud SDK public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg

# Add the Google Cloud SDK repository to your sources list
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

# Update the package list again to include the new repository
sudo apt-get update -y

# Install the Google Cloud CLI
sudo apt-get install google-cloud-cli -y

# Initialize the gcloud CLI
gcloud init

# creds
gcloud auth application-default login


# Install latest kubectl binary
LATEST_KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${LATEST_KUBECTL_VERSION}/bin/linux/arm64/kubectl"
curl -LO "https://dl.k8s.io/release/${LATEST_KUBECTL_VERSION}/bin/linux/arm64/kubectl.sha256"

# Verify the binary with sha256
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --short --client

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y
terraform -version

echo "AWS CLI setup, kubectl, eksctl, and Terraform installation completed."

exit
