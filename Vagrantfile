Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, path: "scripts/bootstrap.sh"
  config.vm.synced_folder "~/Development", "/development"
  config.vm.provider "virtualbox" do |v|
        v.memory = 1024
        v.cpus = 2
    end
end
