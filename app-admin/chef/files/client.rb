# Configuration File For Chef (chef-client)
#
# The chef-client program will connect the local system to the specified
# server URLs through a RESTful API to retrieve its configuration.
#
# By default, the client is configured to connect to a Chef Server
# running on the local system. Change this to reflect your environment.
#
# Chef uses a Ruby DSL for configuration, and this file contains a few
# Ruby idioms. First, symbols. These are designated by a colon sigil, ie,
# :value. Second, in Ruby, everything but false and nil (no quotes or other
# designations) is true, including true, the integer 0 and the string "false".
# So to set the value of a setting to false, write:
#
# some_setting false
#
# Third, Ruby class methods can be used, for example we tell the log to show
# the current time stamp with Chef::Log::Formatter.show_time, below.
#
# log_level specifies the level of verbosity for output.
# valid values are: :debug, :info, :warn, :error, :fatal

log_level          :info

# log_location specifies where the client should log to.
# valid values are: a quoted string specifying a file, or STDOUT with
# no quotes. When run as a daemon (default), STDOUT will produce no output.

log_location       "/var/log/chef/client.log"

# ssl_verify_mode specifies if the REST client should verify SSL certificates.
# valid values are :verify_none, :verify_peer. The default Chef Server
# installation will use a self-generated SSL certificate so this should be
# :verify_none unless you replace the certificate.

ssl_verify_mode    :verify_none

# Server URLs.
#
# chef_server_url specifies the Chef Server to connect to.
# valid values are any HTTP URL (e.g. https://chef.example.com:4443).

chef_server_url    "http://localhost:4000"

# file_cache_path specifies where the client should cache cookbooks, server
# cookie ID, and openid registration data.
# valid value is any filesystem directory location.

file_cache_path    "/var/lib/chef/cache"

file_backup_path   "/var/lib/chef/backup"

# pid_file specifies the location of where chef-client daemon should keep the pid
# file.
# valid value is any filesystem file location.

pid_file           "/var/run/chef/client.pid"

# Mixlib::Log::Formatter.show_time specifies whether the chef-client
# log should contain timestamps.  valid values are true or false (no
# quotes, see above about Ruby idioms). The printed timestamp is
# rfc2822, for example:
# Fri, 31 Jul 2009 19:19:46 -0600

Mixlib::Log::Formatter.show_time = true
