#!/bin/sh

# Build
docker build . --squash -t mytardis/k8s-goofys:latest

# Push
docker push mytardis/k8s-goofys:latest
