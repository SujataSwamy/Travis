#!/bin/bash

# Firebase service account decrypt
-  openssl aes-256-cbc -K $encrypted_bbe4408b9dd8_key -iv $encrypted_bbe4408b9dd8_iv -in demotravistoday-8c218be67d1f.json.enc -out /tmp/demotravistoday-8c218be67d1f.json -d

# Firebase setup
wget --quiet --output-document=/tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.tar.gz
mkdir -p /opt
tar zxf /tmp/google-cloud-sdk.tar.gz --directory /opt
/opt/google-cloud-sdk/install.sh --quiet
source /opt/google-cloud-sdk/path.bash.inc

# Setup and configure the project
gcloud components update
echo 	demotravistoday

gcloud config set project 	demotravistoday


# Activate cloud credentials
gcloud auth activate-service-account --key-file /tmp/demotravistoday-8c218be67d1f.json

# List available options for logging purpose only (so that we can review available options)
gcloud firebase test android models list
gcloud firebase test android versions list

./gradlew build assembleDebug
gcloud firebase test android run --app app/build/outputs/apk/debug/app-debug.apk --type=robo --device model=Pixel2,version=28





