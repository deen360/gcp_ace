Here's a general template for creating a Google Cloud VM instance using the `gcloud` command. You can fill in the placeholders as per your requirements:

```bash
gcloud compute instances create <INSTANCE_NAME> \
    --machine-type=<MACHINE_TYPE> \
    --zone=<ZONE> \
    --image=<IMAGE_NAME> \
    --image-project=<IMAGE_PROJECT> \
    --boot-disk-size=<DISK_SIZE> \
    --boot-disk-type=<DISK_TYPE> \
    --network=<NETWORK> \
    --subnet=<SUBNET> \
    --tags=<TAGS> \
    --metadata=<KEY=VALUE>
```

### Explanation of Parameters:
- `<INSTANCE_NAME>`: Name of your VM instance.
- `--machine-type=<MACHINE_TYPE>`: Specifies the machine type (e.g., `e2-micro`, `e2-medium`).
- `--zone=<ZONE>`: Specifies the zone where the instance will be created (e.g., `us-central1-a`).
- `--image=<IMAGE_NAME>`: Specifies the OS image (e.g., `debian-11-bullseye-v20231102`).
- `--image-project=<IMAGE_PROJECT>`: The project containing the image (e.g., `debian-cloud`).
- `--boot-disk-size=<DISK_SIZE>`: Size of the boot disk in GB (e.g., `10GB`).
- `--boot-disk-type=<DISK_TYPE>`: Type of boot disk (e.g., `pd-standard`, `pd-ssd`).
- `--network=<NETWORK>`: Network to attach the instance to (e.g., `default`).
- `--subnet=<SUBNET>`: Subnetwork (optional if using default network).
- `--tags=<TAGS>`: Network tags (e.g., `http-server,https-server`).
- `--metadata=<KEY=VALUE>`: Custom metadata (e.g., `startup-script=#!/bin/bash`).

### Example:
```bash
gcloud compute instances create my-instance \
    --machine-type=e2-micro \
    --zone=us-central1-a \
    --image=debian-11-bullseye-v20231102 \
    --image-project=debian-cloud \
    --boot-disk-size=10GB \
    --boot-disk-type=pd-standard \
    --network=default \
    --tags=http-server,https-server
```

This example sets up a lightweight Debian VM in the `us-central1-a` zone with a 10GB standard boot disk and allows HTTP/HTTPS traffic.


for load balancer: