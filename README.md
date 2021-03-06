# Samba Module

This module will install and configure a samba (v3) server and allow you to add shares to it.
If setup with ldap, it will created the correct association

## Usage

### Minimal server configuration

```puppet
class { 'samba': 
  workgroup     => 'TEST',
  netbios_name  => 'TEST',
  server_strina => 'Awesome Test FileServer',
}
```
This will do the typical install, configure and service management.

### Declaring one share

```puppet
samba::share { 'homes': 
  options => { 
    'comment'        => 'Home Directories' ,
    'browseable'     => 'no' ,
    'read only'      => 'yes',
    'create mask'    => '0700',
    'directory mask' => '0700',
    'valid users'    => '%S',
  },
}

So far, options key names are not checked, maybe in the futur ...

### Add ldap info to samba

```puppet
class { 'samba::ldap':
  ldap_uri            => 'ldap://localhost',
  ldap_ssl            => 'no',
  ldap_delete_dn      => 'no',
  ldap_password_sync  => 'yes',
  ldap_admin_dna      => 'cn=admin,dc=test',
  ldap_suffix         => 'dc=test',
  ldap_user_suffix    => 'ou=people',
  ldap_group_suffix   => 'ou=groups',
  ldap_machine_suffix => 'ou=computers',
  ldap_idmap_suffix   => 'ou=idmap',
}
```

This add a fragment to smb.conf to handle ldap mapping ... a lot of parameter are still static thought

## Limitations

* This module has been tested on Debian Wheezy, Squeeze.

## License

All the code is freely distributable under the terms of the LGPLv3 license.

## Contact

Need help ? contact@alkivi.fr

## Support

Please log tickets and issues at our [Github](https://github.com/alkivi-sas/)
