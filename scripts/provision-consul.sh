#!/usr/bin/env bash
set -x

###Download latest consul
wget $(curl -s https://www.consul.io/downloads.html | grep linux_amd64.zip | sed  's/.*\(https.*zip\).*/\1/') -O /tmp/consul.zip

###install consul
unzip /tmp/consul.zip -d /tmp
sudo mv /tmp/consul /usr/local/bin
rm /tmp/consul.zip -f

consul --version

###Create a unique, non-privileged system user to run Consul and create its data directory.
sudo useradd --system --home /etc/consul.d --shell /bin/false consul
sudo mkdir --parents /opt/consul
sudo chown --recursive consul:consul /opt/consul
sudo mkdir /var/log/consul
sudo chown consul:consul /var/log/consul

####Checking if /vagrant folder exist
[ -d /vagrant ] && pushd /vagrant

###Creating Consul service file:
sudo cp ./config/consul.service  /etc/systemd/system/consul.service

###Creating  Directory for TLS keys
mkdir -p /etc/consul.d/keys
chown --recursive consul:consul /etc/consul.d

###Enabling the consul service
systemctl enable consul