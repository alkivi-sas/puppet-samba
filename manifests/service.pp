class samba::service () {
  service { $samba::params::samba_service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}

