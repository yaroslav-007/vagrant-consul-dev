#!/usr/bin/env bash

[ -d /vagrant ] && pushd /vagrant
 
sudo rsync --chown=consul:consul --chmod=640  -og -I ./config/config.hcl  /etc/consul.d/config.hcl

###(Re)starting the service
sudo systemctl start consul


###Wait to service to power on in order for the next scripts to run successfuly
sleep 15