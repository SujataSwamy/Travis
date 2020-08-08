#!/bin/bash

# Firebase service account decrypt
- openssl aes-256-cbc -K $encrypted_bbe4408b9dd8_key -iv $encrypted_bbe4408b9dd8_iv -in travisdemo-646f8-e260124a0331.json.enc -out /tmp/travisdemo-646f8-e260124a0331.json -d

# Firebase setup
wget --quiet --output-document=/tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.tar.gz
mkdir -p /opt
tar zxf /tmp/google-cloud-sdk.tar.gz --directory /opt
/opt/google-cloud-sdk/install.sh --quiet
source /opt/google-cloud-sdk/path.bash.inc


# Setup and configure the project
gcloud components update
echo travisdemo-646f8

gcloud config set project travisdemo-646f8


# Activate cloud credentials
gcloud auth activate-service-account --key-file /tmp/travisdemo-646f8-e260124a0331.json

# List available options for logging purpose only (so that we can review available options)
gcloud firebase test android models list
gcloud firebase test android versions list

./gradlew build assembleDebug
gcloud firebase test android run --app app/build/outputs/apk/debug/app-debug.apk --type=robo --device model=Pixel2,version=28





