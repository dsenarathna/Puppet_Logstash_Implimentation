# Class: logstash
#
# This class installs logstash
#
# Parameters:
#
# Actions:
#   - Install logstash
#   - Manage logstash service
#
# Requires:
#   - The java::jdk7 module
#
# Sample Usage:
#
class logstash (
  $logstash_jar  = $logstash::params::logstash_jar_name,
  $logstash_url  = $logstash::params::logstash_jar_url,
) inherits logstash::params {
  require java::jdk7
  include general::linux
  general::linux::systemctl { 'logstash': } #shim for sysv->systemd
  service {
    'logstash':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => [ File['/etc/init.d/logstash'], Exec['deploy_logstash_jar'] ];
  }

  file {
    ['/etc/logstash','/etc/logstash/conf.d','/opt/logstash','/opt/logstash/bin','/var/log/logstash']:
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0644';
    '/etc/init.d/logstash':
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      notify  => [General::Linux::Systemctl['logstash'],Service['logstash']],
      content => template("${::puppet_dir_master}/systems/_LINUX_/etc/init.d/logstash"),
      require => File['/opt/logstash/bin/logstashd'];
    '/opt/logstash/bin/logstashd':
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///puppet_dir_master/systems/_LINUX_/opt/logstash/bin/logstashd';
    '/opt/logstash/logstash.jar':
      ensure  => link,
      target  => "/opt/logstash/${logstash_jar}",
      require => Exec['deploy_logstash_jar'];
    '/var/lib/logstash':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
      mode   => '0644';
  }

  exec {
    'deploy_logstash_jar':
      command => "/usr/bin/wget -O /opt/logstash/${logstash_jar} ${logstash_url}/${logstash_jar}",
      timeout => 0,
      cwd     => '/tmp',
      creates => "/opt/logstash/${logstash_jar}",
      path    => ['/bin','/usr/bin'],
      notify  => Service['logstash'],
      require => File['/opt/logstash'];
  }
}
