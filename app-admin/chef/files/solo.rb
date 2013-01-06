# Configuration File For Chef Solo (chef-solo)
#
# The program chef-solo allows you to run Chef as a standalone program
# without connecting to a remote Chef Server.
#
# Chef uses a Ruby DSL for configuration, and this file may contain some
# Ruby idioms. First, symbols. These are designated by a colon sigil, ie,
# :value. Second, in Ruby, everything but false and nil (no quotes or other
# designations) is true, including true, the integer 0 and the string "false".
# So to set the value of a setting to false, write:
#
# some_setting false
#
# Third, Ruby class methods can be used, for example we tell the log to show
# the current time stamp with Mixlib::Log::Formatter.show_time, below.
#
# log_level specifies the level of verbosity for output.
# valid values are: :debug, :info, :warn, :error, :fatal

log_level          :info

# log_location specifies where the client should log to.
# valid values are: a quoted string specifying a file, or STDOUT with
# no quotes.

log_location       "/var/log/chef/solo.log"

# file_cache_path specifies where solo should look for the cookbooks to use
# valid value is any filesystem directory location. This is slightly
# different from 'normal' client mode as solo is actually downloading (or
# using) the specified cookbooks in this location.

file_cache_path    "/var/lib/chef"

# cookbook_path specifies where solo should look for cookbooks it will use.
# valid value is a string, or array of strings of filesystem directory locations.
# This setting is similar to the server setting of the same name. Solo will use
# this as a search location, in Array order. It should be a subdirectory of
# file_cache_path, above.

cookbook_path      [ "/var/lib/chef/cookbooks" ]

# Mixlib::Log::Formatter.show_time specifies whether the chef-client log should
# contain timestamps.
# valid values are true or false (no quotes, see above about Ruby idioms). The
# printed timestamp is rfc2822, for example:
# Fri, 31 Jul 2009 19:19:46 -0600

Mixlib::Log::Formatter.show_time = true
