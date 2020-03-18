#!/usr/bin/env sh

terraform init -plugin-dir=/usr/tf/plugin/
TF_LOG=debug terraform refresh
TF_LOG=debug terraform plan -out plan
TF_LOG=debug terraform apply plan
