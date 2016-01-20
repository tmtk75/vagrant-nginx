VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box     = "centos65-x86_64-20140116"
  config.vm.box_url = "https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box"

  config.vm.network :forwarded_port, guest:8000, host:8000, id:"http"
  config.vm.network :private_network, ip:"192.168.1.100"

  config.vm.provision :shell, :inline => <<-EOH
    if [ ! -f /usr/bin/puppet ]; then
      rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
      yum install -y puppet-server-3.5.1
      chkconfig puppetmaster on
    fi
  EOH
 
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.module_path    = "modules"
  end
end
