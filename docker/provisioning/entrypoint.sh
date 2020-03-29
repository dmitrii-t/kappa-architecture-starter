#!/usr/bin/env sh

set -e

TF_LOG=debug terraform init -plugin-dir=/home/tf/.terraform.d/plugins/linux_amd64/
TF_LOG=debug terraform refresh
TF_LOG=debug terraform plan -out plan
TF_LOG=debug terraform apply plan
