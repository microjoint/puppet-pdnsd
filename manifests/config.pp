#
class pdnsd::config inherits pdnsd
{

  File {
    owner   => 0,
    group   => 0,
    mode    => '0644',
  }

  file { '/etc/default/pdnsd':
    ensure  => file,
    content => template("${module_name}/default_pdnsd.erb"),
  }

  file { $config:
    ensure  => file,
    content => template($config_template),
  }
}
