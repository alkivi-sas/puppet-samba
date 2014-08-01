class samba::config (
  $workgroup             = $samba::workgroup,
  $server_string         = $samba::server_string,
  $interfaces            = $samba::interfaces,
  $hosts_allow           = $samba::hosts_allow,
  $shares                = $samba::shares,
  $netbios_name          = $samba::netbios_name,
  $log_level             = $samba::log_level,
  $log_file              = $samba::log_file,
  $max_log_size          = $samba::max_log_size,
  $debug_pid             = $samba::debug_pid,
  $debug_uid             = $samba::debug_uid,
  $syslog                = $samba::syslog,
  $printing              = $samba::printing,
  $printcap_name         = $samba::printcap_name,
  $security              = $samba::security,
  $os_level              = $samba::os_level,
  $obey_pam_restrictions = $samba::obey_pam_restrictions,
  $utmp                  = $samba::utmp,
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
