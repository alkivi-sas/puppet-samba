class samba::config (
  $workgroup = $samba::workgroup,
  $server_string = $samba::server_string,
  $interfaces = $samba::interfaces,
  $hosts_allow = $samba::hosts_allow,
  $shares = $samba::shares,
) {
  File {
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Class['samba::service'],
  }

  concat { $samba::params::samba_service_config:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => Class['samba::service'],
  }

  concat::fragment { 'smb_main':
    target  => $samba::params::samba_service_config,
    content => template('samba/smb.conf.erb'),
    order   => 00,
  }

  file {  $samba::params::samba_service_default:
    content => template('samba/etc_default.erb'),
  }

  if($samba::firewall)
  {
    file { '/etc/iptables.d/40-samba.rules':
      source  => 'puppet:///modules/samba/samba.rules',
      require => Package['alkivi-iptables'],
      notify  => Service['alkivi-iptables'],
    }
  }
}
