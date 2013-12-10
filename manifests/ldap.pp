class samba::ldap(
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
) {
  validate_string($ldap_admin_dn)
  validate_string($ldap_suffix)
  validate_string($ldap_user_suffix)
  validate_string($ldap_group_suffix)
  validate_string($ldap_machine_suffix)
  validate_string($ldap_idmap_suffix)
  validate_string($ldap_uri)
  validate_string($ldap_ssl)
  validate_string($ldap_delete_dn)
  validate_string($ldap_password_sync)

  concat::fragment { 'smb_ldap':
    target  => $samba::params::samba_service_config,
    content => template('samba/ldap.conf.erb'),
    order   => 01,
  }

  # TODO : smbpasswd -W to fix admin ldap password in secrets.tdb
}
