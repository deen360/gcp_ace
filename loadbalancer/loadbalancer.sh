echo ""
echo ""
echo "Please export the values."

# Prompt user to input three regions
# Ask the user to input values for the instance name, firewall name, and zone
read -p "Enter INSTANCE_NAME: " INSTANCE_NAME
read -p "Enter FIREWALL_NAME: " FIREWALL_NAME
read -p "Enter ZONE: " ZONE

# Export default port and compute the region from the zone
export PORT=8082
export REGION="${ZONE%-*}"  # Derive the region by removing the last segment of the zone

# Create a new VPC network with automatic subnet creation
gcloud compute networks create nucleus-vpc --subnet-mode=auto

# Create a compute instance in the specified zone within the created network
gcloud compute instances create $INSTANCE_NAME \
          --network nucleus-vpc \
          --zone $ZONE  \
          --machine-type e2-micro  \
          --image-family debian-12  \
          --image-project debian-cloud 

# Uncomment the lines below to create a GKE cluster within the VPC
# gcloud container clusters create nucleus-backend \
# --num-nodes 1 \
# --network nucleus-vpc \
# --zone $ZONE

# Authenticate kubectl to interact with the GKE cluster
# gcloud container clusters get-credentials nucleus-backend \
# --zone $ZONE

# Create a Kubernetes deployment and expose it as a LoadBalancer service
# kubectl create deployment hello-server \
# --image=gcr.io/google-samples/hello-app:2.0
  
# kubectl expose deployment hello-server \
# --type=LoadBalancer \
# --port $PORT
  
#start up script option 1
# Create a startup script for instances in the template can also be apache 

cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF

#0R 
# sttart up script option 2 
# Create a startup script for instances in the template can also be apache 
#cat << EOF > startup.sh
#sudo apt update && sudo apt -y install apache2
#sudo systemctl status apache2
#echo ' <! doctype html><html><body><h1> Welcome to BCReddy Youtube Channel from webserver </h1></body></html>'
#sudo tee /var/www/html/index.html


# Create an instance template with the startup script
gcloud compute instance-templates create web-server-template \
--metadata-from-file startup-script=startup.sh \
--network nucleus-vpc \
--machine-type e2-medium \
--region $ZONE

# Create a target pool for load balancing
gcloud compute target-pools create nginx-pool --region=$REGION

# Create a managed instance group with two instances based on the template
gcloud compute instance-groups managed create web-server-group \
--base-instance-name web-server \
--size 2 \
--template web-server-template \
--region $REGION

# Create a firewall rule to allow HTTP traffic
gcloud compute firewall-rules create $FIREWALL_NAME \
--allow tcp:80 \
--network nucleus-vpc

# Create an HTTP health check
gcloud compute http-health-checks create http-basic-check

# Associate the managed instance group with the health check
gcloud compute instance-groups managed \
set-named-ports web-server-group \
--named-ports http:80 \
--region $REGION

# Create a backend service and attach the instance group
gcloud compute backend-services create web-server-backend \
--protocol HTTP \
--http-health-checks http-basic-check \
--global

gcloud compute backend-services add-backend web-server-backend \
--instance-group web-server-group \
--instance-group-region $REGION \
--global

# Create a URL map that routes all traffic to the backend service
gcloud compute url-maps create web-server-map \
--default-service web-server-backend

# Create an HTTP proxy that uses the URL map
gcloud compute target-http-proxies create http-lb-proxy \
--url-map web-server-map

# Create a forwarding rule for the HTTP proxy to route incoming traffic
gcloud compute forwarding-rules create http-content-rule \
--global \
--target-http-proxy http-lb-proxy \
--ports 80

# Optional duplicate forwarding rule with the specified firewall name
gcloud compute forwarding-rules create $FIREWALL_NAME \
--global \
--target-http-proxy http-lb-proxy \
--ports 80

# List all forwarding rules to verify configuration
gcloud compute forwarding-rules list


