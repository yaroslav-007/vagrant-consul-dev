Vagrant.configure(2) do |config|
  config.vm.provision "shell", path: "../../../scripts/initial-os-setup.sh"
  config.vm.provision "shell", path: "../../../scripts/provision-consul.sh"
  config.vm.provision "shell", path: "../../../scripts/deploy-consul-client.sh"
end