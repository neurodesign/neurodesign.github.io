---
title: Using vagrant to compile jekyll
tags:
  - vagrant
  - jekyll
---

I like to keep my projects stacks inside their own virtual machine, so applications don't clutter my machine. When I started looking into jekyll as a blogging platform, in particular because it's available for free on github pages, I also tried to find a nice Vagrantfile, but couldn't find one that matched my criteria: the vagrant files I found required the files to be edited inside the vm.

Setting up jekyll is pretty straight-forward, and just a gem away (you also need ruby, of course):


    gem install jekyll

You'll also need a javascript runtime. So we'll install nodejs.


    apt-get -y install nodejs

Launching it if simple as well, and you a quick search in the help show you can watch for new files and force polling to allow edition from outside the vm:


    jekyll serve -P 4000 --watch --force_polling

We can take care of launching jekyll as soon as the vm starts, using the :run => "always" option of Vagrant.

Here is the full Vagrantfile:

    VAGRANTFILE_API_VERSION = "2"

    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
      config.vm.box = "ubuntu/trusty64"
      config.vm.box_url = "http://files.vagrantup.com/trusty64.box"
      config.vm.network "forwarded_port", guest: 4000, host: 4000
      config.vm.provision :shell,
        :privileged => true,
        :inline => "apt-get -y install ruby1.9.3 nodejs && gem install github-pages --no-ri --no-rdoc"
      config.vm.provision :shell,
        :run => "always",
        :privileged => false,
        :inline => "cd /vagrant && screen -S jekyll -d -m jekyll serve -P 4000 --watch --force_polling"
    end

Add in a .gitignore (to avoid commiting your .vagrant folder), a _config.yml (to make it ignore the Vagrant & git files), and you're good to go.


This vagrant project is available on github: [vagrant jekyll](https://github.com/neurodesign/vagrant-jekyll).

Clone that project, vagrant up, see the results updated on each modification at [localhost:4000](http://localhost:4000).
