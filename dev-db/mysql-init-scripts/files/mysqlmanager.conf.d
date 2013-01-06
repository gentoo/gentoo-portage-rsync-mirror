#  Here is where we define which server(s) to start.
#  Additional parameters to be passed to mysqlmanager at startup may be added here,
#  which will override the ones in "my.cnf".
#
#  To avoid starting a server just comment it's definition
#  here or it will rant (no default start).
#  Last but not least, spaces are NOT allowed inside the parameters!
#
#  Below are described some suggested parameters to use.
#  The parameters not recognized will be passed through to the mysqlmanager directly.
#
#  Parameter      : description

# ----------------+-----------------------------------------------------------
# mycnf           : string [full path to my.cnf]
#                 : specify the path to my.cnf file to be used
#                 : may contain a [manager] section
# ----------------+-----------------------------------------------------------
#
# Basic default
#
#mysqlmanager_slot_0=()
#
# Start MySQL 5.0.X overriding the my.cnf path
#mysqlmanager_slot_500=(
#	"mycnf=/home/test/my.cnf"
#)
#
