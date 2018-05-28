#
class pdnsd (
) {

  $config_template    = lookup(pdnsd::config_template, String, 'unique', 'pdnsd/pdnsd.conf.erb' )
  $package_ensure     = lookup(pdnsd::package_ensure, String, 'unique', 'present' )
  $service_enable     = lookup(pdnsd::service_enable, Boolean, 'unique', true )
  $service_ensure     = lookup(pdnsd::service_ensure, String, 'unique', 'running' )
  $service_manage     = lookup(pdnsd::service_manage, Boolean, 'unique', true )
  $server_ip          = lookup(pdnsd::server_ip, String, 'unique', '127.0.0.1' )

  $perm_cache         = lookup(pdnsd::perm_cache, Integer, 'unique', 16384)
  $cache_dir          = lookup(pdnsd::cache_dir, String, 'unique', '/var/cache/pdnsd')
  $start_daemon       = lookup(pdnsd::start_daemon, Tuple, 'unique', 'yes')
  $preferred_servers  = lookup(pdnsd::preferred_servers, {merge => 'hash', default_value => undef}) #hash

  case $::osfamily {
    'Debian': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = 'pdnsd'
      $service_name    = 'pdnsd'
    }
    'RedHat': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = 'pdnsd'
      $service_name    = 'pdnsd'
    }
    'SuSE': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = 'pdnsd'
      $service_name    = 'pdnsd'
    }
    'FreeBSD': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = 'net/pdnsd'
      $service_name    = 'pdnsd'
    }
    'Archlinux': {
      $config          = '/etc/pdnsd.conf'
      $package_name    = 'pdnsd'
      $service_name    = 'pdnsd'
    }
    'Linux': {
      # Account for distributions that don't have $::osfamily specific settings.
      case $::operatingsystem {
        'Gentoo': {
          $config          = '/etc/pdnsd.conf'
          $package_name    = 'net-dns/pdnsd'
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

  validate_absolute_path($config)
  validate_string($config_template)
  validate_string($package_ensure)
  validate_string($package_name)
  validate_bool($service_enable)
  validate_string($service_ensure)
  validate_bool($service_manage)
  validate_string($service_name)

  include '::pdnsd::install'
  include '::pdnsd::config'
  include '::pdnsd::service'

  Class['::pdnsd::install'] -> Class['::pdnsd::config'] ~> Class['::pdnsd::service']

}
