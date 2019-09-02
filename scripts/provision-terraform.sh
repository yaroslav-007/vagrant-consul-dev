#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

###Download latest consul
wget $(curl -s https://www.terraform.io/downloads.html| grep linux_amd64.zip | sed  's/.*\(https.*zip\).*/\1/') -O /tmp/terraform.zip

###install consul
unzip /tmp/terraform.zip -d /tmp
sudo mv /tmp/terraform /usr/local/bin
rm /tmp/terraform.zip -f

terraform --version
terraform -install-autocomplete