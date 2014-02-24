class samba::params () {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $samba_service_config  = '/etc/samba/smb.conf'
      $samba_service_default = '/etc/default/samba'
      $samba_service_name    = 'samba'
      $samba_package_name    = 'samba'
      $samba_extra_packages  = ['samba-common-bin' ]
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

