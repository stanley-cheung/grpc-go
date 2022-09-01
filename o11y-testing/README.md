## Build docker images:

In root `grpc-go/` directory:

1. `./buildO11yImage.sh`

 - This pushes the docker image to `gcr.io/{project}/o11y-examples-go`.

## Prerequisites:

1. Create a Kubernetes Cluster

 - Important: when creating the cluster (on the Cloud Console), under Node Pools > default-pool > Security, make sure you select "Allow full access to all Cloud APIs".

2. Get authentication credentials for the cluster

 - `gcloud container clusters get-credentials <cluster-name>`
 - You can verify with `kubectl config view`


## Setup Kubernetes environment:

3. `./o11y-testing/example-setup.sh`

  - This deploys the server and client pod according to the `gke-deployment.yaml`

4. Enter the server pod

  - `kubectl get pods -n grpc-server-namespace-ui`
  - `kubectl exec -it grpc-server-deployment-ui-768cf9b4b-4zjgj -n grpc-server-namespace-ui -- /bin/bash`

5. Start the greeter-server
 - `./o11y-testing/run-greeter-server`

 - This also prints out which IP address the pod is listening on:

   ```
   # Kubernetes-managed hosts file.
   127.0.0.1localhost
   ::1localhost ip6-localhost ip6-loopback
   ...
   10.96.0.45  grpc-server-deployment-ui-66457d4987-5n4qx

   ...

   2022/09/01 18:45:27 server listening at [::]:50051
   ```

6. Enter the client pod
 - `kubectl get pods -n  grpc-client-namespace-ui`
 - `kubectl exec -it grpc-client-deployment-ui-7745bd5c96-j94nh -n  grpc-client-namespace-ui -- /bin/bash`

7. Run the greeter-client

 - Copy the server IP address into the command
 - `./o11y-testing/run-greeter-client 10.96.0.45:50051`

   ```
   ...
   2022/09/01 18:48:27 Greeting: Hello foo
   ```

8. Verify cloud data
 - `./o11y-testing/list.py`


## Clean up

1. `./o11y-testing/example-cleanup.sh`
