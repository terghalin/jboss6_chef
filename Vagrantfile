# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.memory = 1384
    v.cpus = 1
  end

  config.vm.define :cheffy do |srv|
    srv.vm.network "forwarded_port", guest: 8080, host: 18080
  end

    config.vm.provision "chef_zero" do |chef|
      # Specify the local paths where Chef data is stored
      # We'll use berks vendored directory
      chef.cookbooks_path = "vendor"
      chef.environment = "development"
      chef.environments_path = "environments"
      chef.roles_path = "roles"
      chef.add_role("mysql")
      chef.add_role("jboss")
    end
  end
