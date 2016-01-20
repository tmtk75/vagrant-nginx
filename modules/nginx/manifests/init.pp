class nginx {
  include install
  include config
  include service
  Class[install] -> Class[config] ~> Class[service]
}

class nginx::install {
  package { "nginx-release-centos":
    provider => yum,
    ensure   => installed,
    source   => "http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm",
  }
  -> package { nginx:
    ensure => latest,
  }
}

class nginx::config {
  file { "/etc/nginx/nginx.conf":
    ensure  => present,
    content => template("nginx/nginx.conf"),
  }
  file { "/etc/nginx/conf.d/default.conf":
    ensure  => present,
    content => template("nginx/default.conf"),
  }
  file { "/etc/nginx/conf.d/rate-limit.conf":
    ensure => absent,
  }
  file { "/vagrant/log":
    ensure => directory,
    mode   => 0755,
  }
  -> file { "/vagrant/log/nginx":
    ensure => directory,
    mode   => 0755,
  }
}

class nginx::service {
  service { nginx:
    ensure => running,
    subscribe => [Class[config]],
  }
}
