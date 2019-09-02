#!/usr/bin/env bash

# this script is not used in the test
# is just a helper to create the test based on a list of packages

pkg="tmux thin-provisioning-tools python-pip python3-pip git jq curl wget vim language-pack-en sysstat htop ruby ruby-dev python-pylxd python3-pylxd"

for p in ${pkg} ; do echo "describe package('${p}') do
  it { should be_installed }
end
"
done
