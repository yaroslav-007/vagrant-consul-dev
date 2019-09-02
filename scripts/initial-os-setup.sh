#!/usr/bin/env bash
set -x
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install wget unzip jq zip  -y

###web service nginx for the client
[[ $(hostname -s) -eq consul-client-1 ]] && { sudo apt-get install nginx -y ;};

###bind9 for DNS
[[ $(hostname -s) == consul-server* ]] && { sudo apt-get install bind9 -y ;};
exit 0