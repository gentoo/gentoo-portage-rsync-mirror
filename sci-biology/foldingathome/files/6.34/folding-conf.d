# Config file for /etc/init.d/foldingathome
#
# The f@h client configuration can be found in /opt/foldingathome/client.cfg
# Run /opt/foldingathome/initfolding to reconfigure that.
#
# The options may be passed to the Folding client:
#
#  -config      Configure user information
#  -configonly  Configure user information, then exit
#  -help        Display this usage screen
#  -queueinfo   Get information on queued work units
#  -delete x    Delete item #x from work queue
#  -send x      Send result #x to server then exit. Use x=all to send all results
#  -verbosity x Sets the output level, from 1 to 9 (max). The default is 3
#  -pause       Pause after finishing & trying to send current unit
#  -oneunit     Exit after completing one unit
#  -forceasm    Force core assembly optimizations to be used if available
#  -advmethods  Use new advanced scientific cores and/or work units if available
#  -freeBSD     Make brandelf system call on downloaded cores.
#  -openBSD     Make elf2olf system call on downloaded cores.
#  -smp         Use symmetric multiprocessing.
#
# A full listing of options can be found here:
# http://www.stanford.edu/group/pandegroup/folding/console-userguide.html
# But use of other options are not recommended when using the Folding client
# as a service.
#
FOLD_OPTS=""
PIDFILE=/var/run/folding

