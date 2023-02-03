# Class: logstash::shipper
#
# This class installs the logstash shipper
#
# Parameters:
#
# Actions:
#   - Install logstash shipper
#
# Requires:
#
# Sample Usage:
#
class logstash::shipper {
  require redis

  file {
    '/etc/logstash/shipper.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      notify  => Service['logstash'],
      content => template("${::puppet_dir_master}/systems/_LINUX_/etc/logstash/shipper.conf");
  }
}
