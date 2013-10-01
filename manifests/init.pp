class samba (
  $workgroup,
  $netbios_name,
  $server_string,
  $interfaces            = [],
  $hosts_allow           = [],
  $shares                = {},
  $deadtime              = 10,
  $log_level             = 1,
  $log_file              = '/var/log/samba.log',
  $max_log_size          = '5000',
  $debug_pid             = 'yes',
  $debug_uid             = 'yes',
  $syslog                = 1,
  $utmp                  = 'yes',
  $printing              = 'bsd',
  $printcap_name         = '/dev/null',
  $security              = 'user',
  $os_level              = '64',
  $obey_pam_restrictions = 'no',

  $ldap               = true,
  $ldap_uri           = 'ldap://localhost',
  $ldap_ssl           = 'no',
  $ldap_delete_dn     = 'no',
  $ldap_password_sync = 'yes',

  $ldap_admin_dn,
  $ldap_suffix,

  $ldap_user_suffix    = 'ou=people',
  $ldap_group_suffix   = 'ou=groups',
  $ldap_machine_suffix = 'ou=computers',
  $ldap_idmap_suffix   = 'ou=idmap',

  $motd = true,

) {

  if($motd)
  {
    motd::register{'Samba Server': }
  }
  # params check
  validate_string($workgroup)
  validate_string($server_string)
  validate_array($interfaces)
  validate_array($hosts_allow)
  validate_hash($shares)

  if($ldap)
  {
    validate_string($ldap_admin_dn)
    validate_string($ldap_suffix)
    validate_string($ldap_user_suffix)
    validate_string($ldap_group_suffix)
    validate_string($ldap_machine_suffix)
    validate_string($ldap_idmap_suffix)
  }

  # declare all parameterized classes
  class { 'samba::params': }
  class { 'samba::install': }
  class { 'samba::config': }
  class { 'samba::service': }

  # declare relationships
  Class['samba::params'] ->
  Class['samba::install'] ->
  Class['samba::config'] ->
  Class['samba::service']
}

