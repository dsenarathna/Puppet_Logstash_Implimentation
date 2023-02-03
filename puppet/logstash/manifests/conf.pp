# Definition: logstash::conf
#
# This class installs logstash configuration files
#
# Parameters:
#   - The $name of the configuration file
#
# Actions:
#   - Install logstash configuration files
#
# Requires:
#
# Sample Usage:
#   logstash::conf { 'name_of_configfile': }
#
define logstash::conf {
  file {
    "/etc/logstash/conf.d/${name}.conf":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service['logstash'],
      content => template("${::puppet_dir_master}/systems/_LINUX_/etc/logstash/conf.d/${name}.conf");
  }
  file {
    "/etc/logstash/conf.d/${name}":
        ensure => 'absent', 
        notify  => Service['logstash'],
        force => 'true'
  }
}
