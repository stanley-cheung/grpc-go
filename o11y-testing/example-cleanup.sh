#!/bin/bash -x

set -e
cd "$(dirname "$0")"

# now delete our deployment of service and client
kubectl delete -f ./gke-deployment.yaml
