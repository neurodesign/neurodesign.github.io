# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Feel free to change the base box, as long as you
  # stick to a debian based box
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_url = "http://files.vagrantup.com/trusty64.box"

  config.vm.network "forwarded_port", guest: 4000, host: 4000 

  config.vm.provision :shell,
    :privileged => true,
    :inline => "apt-get -y install ruby1.9.3 && apt-get -y install nodejs && gem install github-pages --no-ri --no-rdoc"
  config.vm.provision :shell,
    :run => "always",
    :privileged => false,
    :path => "provision/launch-jekyll.sh"
end
