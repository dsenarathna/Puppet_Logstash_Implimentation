# Class: logstash::params
#
# This class manages parameters for the logstash module
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class logstash::params {
  $logstash_jar_name = $logstash_jar_name ? {
    ''      => 'logstash-1.1.12-flatjar.jar',
    default => $logstash_jar_name
  }

  $logstash_jar_url = $logstash_jar_url ? {
    ''      => "http://debian/logstash",
    default => $logstash_jar_url
  }
}
