### To deploy the load balancer on google cloud use the SSH on the gcp console 

curl -LO https://raw.githubusercontent.com/deen360/gcp_ace/main/loadbalancer/loadbalancer.sh \n
sudo chmod +x loadbalancer.sh \n
./loadbalancer.sh


# Steps in the sh file
1. Display messages prompting the user to export values.  
2. Prompt the user to input `INSTANCE_NAME`, `FIREWALL_NAME`, and `ZONE`.  
3. Export default values for `PORT` and compute `REGION` from `ZONE`.  
4. Create a new VPC network with automatic subnet creation.  
5. Create a compute instance in the specified zone within the VPC network.  
6. (Optional) Create a GKE cluster within the VPC.  
7. (Optional) Authenticate `kubectl` to interact with the GKE cluster.  
8. (Optional) Create a Kubernetes deployment and expose it as a LoadBalancer service.  
9. Write a startup script for configuring new instances.  
10. Create an instance template with the startup script.  
11. Create a target pool for load balancing.  
12. Create a managed instance group with two instances based on the template.  
13. Create a firewall rule to allow HTTP traffic.  
14. Create an HTTP health check.  
15. Associate the health check with the managed instance group.  
16. Create a backend service and attach the instance group.  
17. Create a URL map to route traffic to the backend service.  
18. Create an HTTP proxy using the URL map.  
19. Create a forwarding rule for the HTTP proxy to route incoming traffic.  
20. (Optional) Create an additional forwarding rule using the specified firewall name.  
21. Verify the configuration by listing all forwarding rules.