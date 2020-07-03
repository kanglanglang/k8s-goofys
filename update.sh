#!/bin/sh

# Build
docker build . -t mytardis/k8s-goofys:latest

# Push
docker push mytardis/k8s-goofys:latest
