class samba::install () {
  package { $samba::params::samba_package_name:
    ensure => installed,
  }
}
