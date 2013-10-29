define samba::share(
  $options,
) {
  validate_hash($options)

  concat::fragment { "smb_share_${title}":
    target  => $samba::params::samba_service_config,
    content => template('samba/share.conf.erb'),
    order   => 10,
  }
}
