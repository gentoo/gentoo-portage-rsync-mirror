# Configuration File For Chef SOLR Indexer (chef-solr-indexer)
#
# The chef-indexer program runs on the Chef Server to generate search indexes
# of node data stored in the Server's CouchDB store.
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
# the current time stamp with Chef::Log::Formatter.show_time, below.
#
# log_location specifies where the indexer should log to.
# valid values are: a quoted string specifying a file, or STDOUT with
# no quotes. When run as a daemon (default), STDOUT will produce no output.

log_location       "/var/log/chef/solr.log"

# search_index_path specifies where the indexer should store the indexes.
# valid value is any filesystem directory location.

search_index_path  "/var/lib/chef/search_index"

solr_jetty_path    "/var/lib/chef/solr/jetty"
solr_home_path     "/var/lib/chef/solr/home"
solr_data_path     "/var/lib/chef/solr/data"
solr_heap_size     "256M"

# Mixlib::Log::Formatter.show_time specifies whether the chef-client log should
# contain timestamps.
# valid values are true or false (no quotes, see above about Ruby idioms). The
# printed timestamp is rfc2822, for example:
# Fri, 31 Jul 2009 19:19:46 -0600

Mixlib::Log::Formatter.show_time = true
