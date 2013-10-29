class samba (
  $workgroup,
  $netbios_name,
  $server_string,
  $interfaces            = [],
  $hosts_allow           = [],
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

  $motd                  = true,
  $firewall              = true,

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

