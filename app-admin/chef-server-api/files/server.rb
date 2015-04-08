# Configuration File For Chef (chef-server)
#
# chef-server is a Merb application slice. By default it is configured to
# run via Thin, the default Merb adapter. It can be run as:
#
#		chef-server -p 4000 -e production -a thin
#
# This starts up the RESTful Chef Server API on port 4000 in production mode
# using the thin server adapter.
#
# This file configures the behavior of the running server itself.
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

# log_location specifies where the server should log to.
# valid values are: a quoted string specifying a file, or STDOUT with
# no quotes. This is the application log for the Merb workers that get
# spawned.

log_location       "/var/log/chef/server.log"

# ssl_verify_mode specifies if the REST client should verify SSL certificates.
# valid values are :verify_none, :verify_peer. The default Chef Server
# installation will use a self-generated SSL certificate so this should be
# :verify_none unless you replace the certificate.

ssl_verify_mode    :verify_none

# chef_server_url specifies the URL for the server API. The process actually
# listens on 0.0.0.0:PORT.
# valid values are any HTTP URL.

chef_server_url    "http://localhost:4000"

# cookbook_path is a Ruby array of filesystem locations to search for cookbooks.
# valid value is a string, or an array of strings of filesystem directory
# locations. This setting is searched beginning (index 0) to end in order. You
# might specify multiple search paths for cookbooks if you want to use an
# upstream source, and provide localised "site" overrides. These should come
# after the 'upstream' source. The default value, /var/lib/chef/cookbooks does
# not contain any cookbooks by default.
# See the Chef Wiki for more information about setting up a local repository
# for working on cookbooks.
# http://wiki.opscode.com/display/chef/Chef+Repository

cookbook_path         [ "/var/lib/chef/cookbooks" ]
cookbook_tarball_path "/var/lib/chef/cookbook-tarballs"

# file_cache_path specifies where the client should cache cookbooks, server
# cookie ID, and openid registration data.
# valid value is any filesystem directory location.

file_cache_path    "/var/lib/chef/cache"

# node_path specifies a location for where to find node-specific recipes.
# valid values are any filesystem direcory location.

node_path          "/var/lib/chef/nodes"

# openid_store_path specifies a location where to keep openid nonces for clients.
# valid values are any filesystem directory location.
#
# NOTE: OpenID is deprecated and this option may not be used, kept for
# historical purposes.

openid_store_path  "/var/lib/chef/openid/store"

# openid_store_path specifies a location where to keep openid nonces for clients.
# valid values are any filesystem directory location.
#
# NOTE: OpenID is deprecated and this option may not be used, kept for
# historical purposes and may be removed.

openid_cstore_path "/var/lib/chef/openid/cstore"

# role_path designates where the server should load role JSON and Ruby DSL
# files from.
# valid values are any filesystem directory location. Roles are a feature
# that allow you to easily reuse lists of recipes and attribute settings.
# Please see the Chef Wiki page for information on how to utilize the feature.
# http://wiki.opscode.com/display/chef/Roles
#
# NOTE: The role_path setting is deprecated on the chef-server, as the
# roles are now stored directly in CouchDB rather than on the filesystem.
# This option is kept for historical purposes and may be removed.

role_path          "/var/lib/chef/roles"

# cache_options sets options used by the moneta library for local cache for
# checksums of compared objects.

cache_options({
  :path => "/var/lib/chef/cache/checksums",
  :skip_expires => true
})

# Mixlib::Log::Formatter.show_time specifies whether the chef-client log should
# contain timestamps.
# valid values are true or false (no quotes, see above about Ruby idioms). The
# printed timestamp is rfc2822, for example:
# Fri, 31 Jul 2009 19:19:46 -0600

Mixlib::Log::Formatter.show_time = true

# The following options configure the signing CA so it can be read by
# non-privileged user for the server daemon.

signing_ca_path    "/etc/chef/certificates"
signing_ca_cert    "/etc/chef/certificates/cert.pem"
signing_ca_key     "/etc/chef/certificates/key.pem"

sandbox_path       "/var/lib/chef/sandboxes"
checksum_path      "/var/lib/chef/checksums"

openid_store_path  "/var/lib/chef/openid/store"
search_index_path  "/var/lib/chef/search_index"
