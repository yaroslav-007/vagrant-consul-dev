#!/usr/bin/env bash
[ -d /vagrant ] && pushd /vagrant
 
sudo cp ./config/config.hcl  /etc/consul.d/config.hcl

###(Re)starting the service
systemctl restart consul