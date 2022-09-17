#!/bin/bash -x

set -e
cd "$(dirname "$0")"

export PROJECT=`gcloud config get-value project`
export PROJNUM=`gcloud projects describe $PROJECT --format="value(projectNumber)"`
KUBECTL_CONFIG=`kubectl config get-clusters |grep $PROJECT`
NUM_CONFIGS=`echo $KUBECTL_CONFIG |wc -w`

if (($NUM_CONFIGS>1)); then
  echo Found $NUM_CONFIGS configs... exiting
  exit 1
fi

kubectl config set-context $KUBECTL_CONFIG
kubectl config use-context $KUBECTL_CONFIG

# deploy
cat ./gke-deployment.yaml | envsubst | kubectl apply -f -
