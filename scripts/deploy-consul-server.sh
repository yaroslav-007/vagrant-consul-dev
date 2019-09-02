#!/usr/bin/env bash

[ -d /vagrant ] && pushd /vagrant

###Creating variables for uploading 
id_host=$(hostname -s | grep -Po '.(?=.{0}$)')
id_key="$(($id_host - 1))"

####Deploy config files
sudo rsync --chown=consul:consul --chmod=640  -og -I ./config/config-server-$id_host.hcl  /etc/consul.d/config.hcl

###Enable ACL
#sudo rsync --chown=consul:consul --chmod=640  -og -I ./config/agent.hcl  /etc/consul.d/agent.hcl

###Uploading keys
sudo rsync --chown=consul:consul --chmod=444  -og -I ./keys/server/dc1-server-consul-$id_key*  /etc/consul.d/keys
sudo rsync --chown=consul:consul --chmod=444  -og -I ./keys/server/dc1-cli-consul-0*  /etc/consul.d/keys
sudo rsync --chown=consul:consul --chmod=444  -og -I ./keys/server/consul-agent-ca.pem  /etc/consul.d/keys

###DNS configuration
sudo cp ./config/bind/named.conf.options /etc/bind/named.conf.options
sudo cp ./config/bind/consul.conf  /etc/bind/consul.conf
sudo systemctl restart bind9

###Putting env variables to vagrant user
echo "export CONSUL_HTTP_ADDR=https://localhost:8501" >> /home/vagrant/.bashrc
echo "export CONSUL_CACERT=/etc/consul.d/keys/consul-agent-ca.pem" >> /home/vagrant/.bashrc
echo "export CONSUL_CLIENT_CERT=/etc/consul.d/keys/dc1-cli-consul-0.pem" >> /home/vagrant/.bashrc
echo "export CONSUL_CLIENT_KEY=/etc/consul.d/keys/dc1-cli-consul-0-key.pem" >> /home/vagrant/.bashrc

###(Re)starting the service
sudo systemctl start consul

###Wait to service to power on in order for the next scripts to run successfuly
sleep 15