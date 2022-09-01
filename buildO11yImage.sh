#!/bin/bash
set -e

IMAGENAME=o11y-examples-go
TAG=1.50.0-dev
PROJECTID=`gcloud config get-value project`

echo Building ${IMAGENAME}:${TAG}

docker build --build-arg builddate="$(date)" --no-cache -t o11y/${IMAGENAME}:${TAG} -f o11y.dockerfile .

docker tag o11y/${IMAGENAME}:${TAG} gcr.io/${PROJECTID}/${IMAGENAME}:${TAG}

docker push gcr.io/${PROJECTID}/${IMAGENAME}:${TAG}
