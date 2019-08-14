#!/usr/bin/env bash
[ -d /vagrant ] && pushd /vagrant
 
sudo cp ./config/config.hcl  /etc/consul.d/config.hcl

###(Re)starting the service
sudo systemctl restart consul

###Wait to service to power on in order for the next scripts to run successfuly
sleep 20