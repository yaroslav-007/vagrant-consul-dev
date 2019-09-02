Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.provision "shell", path: "./scripts/initial-os-setup.sh"

    (1..3).each do |i|
      config.vm.define "consul-server-#{i}" do |node|
         node.vm.hostname = "consul-server-#{i}"
         if i == 1
          node.vm.network :forwarded_port, host: 8501, guest: 8501 
         end
         node.vm.provision "shell", path: "./scripts/provision-consul.sh"
         node.vm.provision "shell", path: "./scripts/deploy-consul-server.sh"
         node.vm.network "private_network", ip: "192.168.50.#{i+3}"
      end
    end


    (1..2).each do |i|
      config.vm.define "consul-client-#{i}" do |node|
         node.vm.hostname = "consul-client-#{i}"
         node.vm.provision "shell", path: "./scripts/provision-consul.sh"
         node.vm.provision "shell", path: "./scripts/deploy-consul-client.sh"
         node.vm.network "private_network", ip: "192.168.50.#{i+9}"
      end
    end
end