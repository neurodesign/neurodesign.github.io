# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "http://files.vagrantup.com/trusty64.box"

  config.vm.network "forwarded_port", guest: 4000, host: 4000 

  config.vm.provision :shell,
    :privileged => true,
    :inline => "apt-get -y install ruby1.9.3 && apt-get -y install nodejs && gem install github-pages --no-ri --no-rdoc"

  config.vm.provision :shell,
    :run => "always",
    :privileged => false,
    :inline => "cd /vagrant && screen -S jekyll -d -m jekyll serve -P 4000 --watch --force_polling"
end
