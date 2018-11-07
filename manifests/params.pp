#
class pdnsd::params {
  $config = undef

  case $::osfamily {
    'Debian': {
      $package = {
        'pdns-server' => {},
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an \
      ${::osfamily} based system.")
    }
  }
}
