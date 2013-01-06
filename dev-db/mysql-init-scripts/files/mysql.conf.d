#  Here is where we define which server(s) to start.
#  Additional parameters to be passed to mysqld at startup may be added here,
#  which will override the ones in "my.cnf".
#
#  Below are described some suggested parameters to use.
#  The parameters not recognized will be passed through to the mysqld daemon
#  directly!
#  To avoid starting a server just comment it's definition.
#
#  Last but not least, SPACES are NOT allowed inside the parameters!
#
#  Parameter      : description
# ----------------+-----------------------------------------------------------
# nice            : integer [-20 .. 19 ] default 0
#                 : change the priority of the server -20 (high) to 19 (low)
#                 : see "man nice 1" for description
# ----------------+-----------------------------------------------------------
# mycnf           : string [full path to my.cnf]
#                 : specify the path to my.cnf file to be used
# ----------------+-----------------------------------------------------------
# startup_timeout : integer [seconds] default 15
#                 : time to wait for mysqld up and running, after this it's
#                 : marked as failed
# ----------------+-----------------------------------------------------------
#
#  Additional parameters
#  Parameter      : description
# ----------------+-----------------------------------------------------------
# server-id       : integer [1 .. 255]
#                 : Uniquely identifies the server instance in the community
#                 : of replication partners.
# ----------------+-----------------------------------------------------------
# port            : integer [1025 .. 65535] default 3306
#                 : Port number to use for connection.
#                 : Looses any meaning if skip-networking is set.
# ----------------+-----------------------------------------------------------
# skip-networking : NULL
#                 : Don't allow connection through TCP/IP.
# ----------------+-----------------------------------------------------------
# log-bin         : string [name of the binlog files]
#                 : Log update queries in binary format. Optional (but
#                 : strongly recommended to avoid replication problems if
#                 : server's hostname changes) argument should be the chosen
#                 : location for the binary log files.
# ----------------+-----------------------------------------------------------
# Additionally the following variables are recognized:
#
# Be more verbose, accepts values from 1 to 4
#DEBUG=4
#
# The default location for the "master" pid file
#MYSQL_GLOB_PID_FILE="/var/run/svc-started-mysqld"
#
# The timeout for a failed attempt to stop a server
#STOPTIMEOUT=120
#

# The parameters are passed in a bash array variable,
# the variable name is mysql_slot_0_[server-num]
# "server-num" is an optional number used to start multiple servers
#
# Examples:
#
# start a default server with default options:
#mysql_slot_0=()
#
# start MySQL reniced, overriding some start parameters
#mysql_slot_0=(
#   "nice=-5"
#   "server-id=123"
#   "log-bin="myhost"
#   "port=3307"
#)
#
# start another server, different my.cnf
#mysql_slot_0_1=(
#   "mycnf=/home/test/my.cnf"
#   "server-id=124"
#)
#
