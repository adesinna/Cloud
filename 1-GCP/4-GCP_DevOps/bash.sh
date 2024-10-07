#!/bin/bash

# Set variables
PROJECT_ID="your-project-id"
ZONE="us-central1-a"
INSTANCE_NAME="my-instance"
MACHINE_TYPE="e2-medium"
IMAGE_FAMILY="debian-11"
IMAGE_PROJECT="debian-cloud"
NETWORK="default"
SUBNET="default"

# Authenticate if needed (you may need to manually log in)
gcloud auth login

# Set the project
gcloud config set project $PROJECT_ID

# Create the instance
gcloud compute instances create $INSTANCE_NAME \
    --zone=$ZONE \
    --machine-type=$MACHINE_TYPE \
    --image-family=$IMAGE_FAMILY \
    --image-project=$IMAGE_PROJECT \
    --network=$NETWORK \
    --subnet=$SUBNET

echo "Instance $INSTANCE_NAME created in project $PROJECT_ID and zone $ZONE"
