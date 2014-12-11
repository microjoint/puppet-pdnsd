class pdnsd::params {

  $config_template    = hiera(pdnsd::config_template, 'pdnsd/pdnsd.conf.erb' )
  $package_ensure     = hiera(pdnsd::package_ensure, 'present' )
  $service_enable     = hiera(pdnsd::service_enable, true )
  $service_ensure     = hiera(pdnsd::service_ensure, 'running' )
  $service_manage     = hiera(pdnsd::service_manage, true )
  $server_ip          = hiera(pdnsd::server_ip, '127.0.0.1' )

  $perm_cache         = hiera(pdnsd::perm_cache, 16384)
  $cache_dir          = hiera(pdnsd::cache_dir, '/var/cache/pdnsd')

  case $::osfamily {
    'Debian': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsd'
    }
    'RedHat': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsd'
    }
    'SuSE': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsd'
    }
    'FreeBSD': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = ['net/pdnsd']
      $service_name    = 'pdnsd'
    }
    'Archlinux': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = [ 'pdnsd' ]
      $service_name    = 'pdnsd'
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      case $::operatingsystem {
        'Gentoo': {
          $config          = '/etc/pdnsd.conf'
          $package_name    = ['net-dns/pdnsd']
          $service_name    = 'pdnsd'
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
