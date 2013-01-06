# Configuration File For Chef (chef-server-webui)
#
# chef-server-webui is a Merb application slice. By default it is configured to
# run via Thin, the default Merb adapter. This should be run as:
#
#   chef-server-webui -p 4040 -e production -a thin
#
# This starts up the Chef Server WebUI on port 4040 in production mode using
# the thin server adapter.
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

log_location       "/var/log/chef/server-webui.log"

# ssl_verify_mode specifies if the REST client should verify SSL certificates.
# valid values are :verify_none, :verify_peer. The default Chef Server
# installation will use a self-generated SSL certificate so this should be
# :verify_none unless you replace the certificate.

ssl_verify_mode    :verify_none

# chef_server_url specifies the URL for the server API. The process actually
# listens on 0.0.0.0:PORT.
# valid values are any HTTP URL.

chef_server_url    "http://localhost:4000"

# file_cache_path specifies where the client should cache cookbooks, server
# cookie ID, and openid registration data.
# valid value is any filesystem directory location.

file_cache_path    "/var/lib/chef/cache"

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

# Mixlib::Log::Formatter.show_time specifies whether the chef-client log should
# contain timestamps.
# valid values are true or false (no quotes, see above about Ruby idioms). The
# printed timestamp is rfc2822, for example:
# Fri, 31 Jul 2009 19:19:46 -0600

Mixlib::Log::Formatter.show_time = true

signing_ca_cert "/etc/chef/certificates/cert.pem"
signing_ca_key "/etc/chef/certificates/key.pem"

# web_ui_client_name specifies the user to use when accessing the Chef
# Server API. By default this is already set to "chef-webui".
#
# This user gets created by the chef-server and stored in CouchDB the
# first time the server starts up if the user and key don't exist.

web_ui_client_name "chef-webui"

# web_ui_admin_user_name and web_ui_admin_default_password specify the
# user and password that a human can use to initially log into the
# chef-server-webui when it starts. The default value for the user is 'admin'
# and the default password is'p@ssw0rd1' should be changed immediately on
# login. The web form will display the password reset page on first login.

web_ui_admin_user_name "admin"
web_ui_admin_default_password "p@ssw0rd1"

# web_ui_key specifics the file to use for authenticating with the Chef
# Server API. By default this is already set to "/etc/chef/webui.pem".
#
# This file gets created by the chef-server and the public key stored in
# CouchDB the first time the server starts up if the user and key don't
# exist.

web_ui_key "/etc/chef/webui.pem"
