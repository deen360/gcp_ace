#!/bin/bash

# Prompt the user to input the compute region
read -p "Enter the Google Cloud region (e.g., us-central1): " REGION
gcloud config set compute/region "$REGION"

# Prompt the user to input the bucket name
read -p "Enter the name of the Cloud Storage bucket to create: " BUCKET_NAME

# Create a new Google Cloud Storage bucket
gcloud storage buckets create gs://$BUCKET_NAME

# Download an image of Ada Lovelace from Wikimedia
curl -o ada.jpg https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Ada_Lovelace_portrait.jpg/800px-Ada_Lovelace_portrait.jpg

# Upload the downloaded image to the Cloud Storage bucket
gcloud storage cp ada.jpg gs://$BUCKET_NAME

# Delete the local image file
rm ada.jpg

# Download the image back from the bucket to the current directory
gcloud storage cp -r gs://$BUCKET_NAME/ada.jpg .

# Copy the image to a folder named "image-folder" within the bucket
gcloud storage cp gs://$BUCKET_NAME/ada.jpg gs://$BUCKET_NAME/image-folder/

# List all objects in the bucket
gcloud storage ls gs://$BUCKET_NAME

# Display detailed information about the uploaded image
gcloud storage ls -l gs://$BUCKET_NAME/ada.jpg

# Make the image publicly readable
gsutil acl ch -u AllUsers:R gs://$BUCKET_NAME/ada.jpg

# Remove public read access for the image
#gsutil acl ch -d AllUsers gs://$BUCKET_NAME/ada.jpg

# Delete the image from the bucket
#gcloud storage rm gs://$BUCKET_NAME/ada.jpg
