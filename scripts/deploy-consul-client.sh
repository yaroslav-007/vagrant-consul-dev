#!/usr/bin/env bash
set -x
###Creating variables for uploading 
id_host=$(hostname -s | grep -Po '.(?=.{0}$)')
id_key="$(($id_host - 1))"


[ -d /vagrant ] && pushd /vagrant

###Uploading consul agent config file
sudo rsync --chown=consul:consul --chmod=640  -og -I ./config/config-client-$id_host.hcl  /etc/consul.d/config.hcl
[[ $(hostname -s) -eq consul-client-1 ]] && sudo rsync --chown=consul:consul --chmod=640  -og -I ./config/web.json  /etc/consul.d/web.json


###ACL to be implemented
#sudo rsync --chown=consul:consul --chmod=640  -og -I ./config/agent.hcl  /etc/consul.d/agent.hcl

###Upload TLS keys
sudo rsync --chown=consul:consul --chmod=444  -og -I ./keys/client/dc1-client-consul-$id_key* /etc/consul.d/keys
sudo rsync --chown=consul:consul --chmod=444  -og -I ./keys/client/consul-agent-ca.pem /etc/consul.d/keys

###(Re)starting the service
sudo systemctl start consul

###Wait to service to power on in order for the next scripts to run successfuly
sleep 15