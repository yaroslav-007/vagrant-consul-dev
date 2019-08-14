Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.provision "shell", path: "./scripts/provision-consul.sh"
    config.vm.provision "shell", path: "./scripts/deploy-consul.sh"
    config.vm.define "consul-server-1" do |c1|
      c1.vm.hostname = "consul-server-1"
      c1.vm.network :forwarded_port, host: 8500, guest: 8500
    end
end