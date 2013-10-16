class pdnsd::params {

  $config_template    = 'pdnsd/pdnsd.conf.erb'
  $package_ensure     = 'present'
  $preferred_servers  = []
  $service_enable     = true
  $service_ensure     = 'running'
  $service_manage     = true
	$server_ip          = '127.0.0.1'

  $perm_cache         = 2048
	$cache_dir          = '/var/cache/pdnsd'

  case $::osfamily {
    'Debian': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsd'
    }
    'RedHat': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsdd'
    }
    'SuSE': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsd'
    }
    'FreeBSD': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = ['net/pdnsd']
      $service_name    = 'pdnsdd'
    }
    'Archlinux': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsdd'
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      case $::operatingsystem {
        'Gentoo': {
          $config          = '/etc/pdnsd.conf'
          $package_name    = ['net-dns/pdnsd']
          $service_name    = 'pdnsdd'
        }
        default: {
          fail("The ${module_name} module is not supported on an ${::operatingsystem} distribution.")
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
