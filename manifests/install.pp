class samba::install () {
  package { $samba::params::samba_package_name:
    ensure => installed,
  }

  package { $samba::params::samba_extra_packages:
    ensure => installed,
  }
}
