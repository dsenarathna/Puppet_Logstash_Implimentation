# Class: logstash::disable
#
# Stops the logstash daemon and disables it at boot time
#
# Parameters:
#
# Actions:
#   - Stop logstash
#   - Disable logstash service
#
# Requires:
#
# Sample Usage:
#
class logstash::disable inherits logstash {
  Service ['logstash'] {
      ensure     => stopped,
      enable     => false,
  }
}
