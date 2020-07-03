#!/bin/sh

mkdir ~/.aws
echo "[default]" > ~/.aws/credentials
echo "aws_access_key_id = ${KEY}" >> ~/.aws/credentials
echo "aws_secret_access_key = ${SECRET}" >> ~/.aws/credentials

if [ -d $MOUNT_DIR ]; then
  mkdir -p $MOUNT_DIR
fi

syslog-ng

# add --debug_s3 param to debug API calls
goofys -o allow_other -f --endpoint $ENDPOINT $BUCKET $MOUNT_DIR
