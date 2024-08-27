#!/bin/bash
#Script to renew yandex cloud token
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

echo $YC_TOKEN
