#! /usr/bin/perl -w

# KuroBox/Linkstation Clock Calibration Program
#
# Sets the internal system 'tickadj' variable to
# the optimum value, computed by comparing elapsed
# time on the local box versus that indicated by
# an external NTP server.
#
# The sample window is set to 5min by default, but
# empirical tests indicate an interval even as low
# as 1min gives pretty good results.
#
# Use as:  adjtime.pl -t -s 68.12.13.56 -i 60
#          adjtime.pl -v -s 68.12.13.56 -i 60
#
# 2005-02-13 v0.2 don north ak6dn@mindspring.com
# - initial version
# 2005-02-15 v0.3 don north
# - added error checking for missing servers, etc
# - range limited tickadj to +/-10% per iteration
# 2005-02-20 v0.4 don north
# - added retry count/delay for ntp server

# generic defaults
my $VERSION = 'v0.4'; # version of code
my $DEBUG = 0; # set to 1 for debug messages
my $VERBOSE = 0; # set to 1 for verbose messages

# specific defaults
my $NTPSERVER = ''; # ip address of NTP server
my $INTERVAL = 5*60; # seconds default sample interval
my $CHECKEND = 0; # set to 1 to check final tick calibration
my $CHECKONLY = 0; # set to 1 to only check clock, no tick update
my $RETRYCOUNT = 8; # retry count before giving up
my $RETRYDELAY = 5; # base retry delay, in seconds

my $ERROR = 0;
for (my $i = 0; $i <= $#ARGV; $i++) {
    if    ($ARGV[$i] eq '-h') { $ERROR = 1; }
    elsif ($ARGV[$i] eq '-d') { $VERBOSE = 1; $DEBUG = 1; }
    elsif ($ARGV[$i] eq '-v') { $VERBOSE = 1; }
    elsif ($ARGV[$i] eq '-c') { $CHECKEND = 1; }
    elsif ($ARGV[$i] eq '-t') { $VERBOSE = 1; $CHECKONLY = 1; }
    elsif ($ARGV[$i] eq '-s') { $NTPSERVER = $ARGV[++$i]; }
    elsif ($ARGV[$i] eq '-i') { $INTERVAL = $ARGV[++$i]; }
    elsif ($ARGV[$i] eq '-r') { $RETRYCOUNT = $ARGV[++$i]; }
    elsif ($ARGV[$i] eq '-R') { $RETRYDELAY = $ARGV[++$i]; }
    else                      { $ERROR = 1; }
}

# say hello
printf STDERR "adjtime.pl %s for Kurobox/Linkstation (perl %g)\n", $VERSION, $] if $VERBOSE;

# check for correct arguments present, print usage if errors
if ($ERROR || $INTERVAL <= 0) {
    print STDERR "Usage: $0 [options...]\n";
    print STDERR <<"EOF";
       -h            help; print this message
       -d            enable debug mode
       -v            verbose status reporting
       -t            test only; check clock calibration, no update
       -c            check clock calibration after setting tickadj
       -s IPADDR     ip address of NTP server [use /etc/ntp.conf]
       -i DELAY      sample interval, seconds [$INTERVAL]
       -r COUNT      NTP server retry count [$RETRYCOUNT]
       -R DELAY      NTP server query retry delay, seconds [$RETRYDELAY]
EOF
    # exit if errors...
    die "Aborted due to command line errors.\n";
}

# globals
my $DELTA = 0; # actual time slept, seconds
my $OFFSET = 0; # clock error, seconds

# --------------------------------------------------------------------------------

# get an ntp time server from the ntp config file in none specified

unless ($NTPSERVER) {
    if (open(INP, "< /etc/ntp.conf")) {
	while (my $line = scalar(<INP>)) {
	    if ($line =~ m/^\s*server\s+(\S+)/i) {
		$NTPSERVER = $1;
		last;
	    }
	}
	close(INP);
    }
}
printf STDERR "Using NTP server at '%s'\n", $NTPSERVER if $VERBOSE;

# --------------------------------------------------------------------------------

# get the calibration factors by syncing the clock an hour apart
#
#   ntpdate -b server; sleep 3600; ntpdate -b server
#   13 Sep 14:55:31 ntpdate[8507]: step time server 192.168.1.1 offset 0.190378 sec
#   13 Sep 15:55:28 ntpdate[8509]: step time server 192.168.1.1 offset -3.261289 sec

if (1) { 

    # set the clock from the ntp server, discard offset
    $OFFSET = get_offset();
    die "Error: no NTP server response from $NTPSERVER" if $OFFSET eq 'N/A';
    printf STDERR "Initial time offset is %f seconds\n", $OFFSET if $VERBOSE;
	   
    # wait a long time...
    printf STDERR "Going to sleep for %d seconds ... ", $INTERVAL if $VERBOSE;
    $DELTA = time();
    sleep($INTERVAL);
    $DELTA = time()-$DELTA;
    printf STDERR "slept for %d seconds\n", $DELTA if $VERBOSE;

    # set the clock from the ntp server, offset is our clock error
    $OFFSET = get_offset();
    die "Error: no NTP server response from $NTPSERVER" if $OFFSET eq 'N/A';
    printf STDERR "Final time offset is %f seconds\n", $OFFSET if $VERBOSE;

}

# --------------------------------------------------------------------------------

# Now compute the correct value of the tickadj number as:
#
#   corr tick = curr tick * (sample time [sec] + offset [sec]) / sample time [sec]
#             = 10000 * (3600 + (-3.261289)) / 3600
#             = 9991

if (1) {

    my ($TICKOLD,$TICKNEW,$TICKOPT,$TICKEND) = (10000,10000,10000,10000);

    # get current tickadj value
    $TICKOLD = get_tickadj();
    printf STDERR "Current tick adjustment is %d\n", $TICKOLD if $VERBOSE;

    # compute what the tickadj should be based on time measurement
    $TICKOPT = $TICKOLD*($DELTA+$OFFSET)/$DELTA;
    printf STDERR "Optimal tick adjustment is %d [%f]\n", int($TICKOPT+0.5),$TICKOPT if $VERBOSE;
    # only change the tickadj by at most +/-10% in one shot, convert to an int
    $TICKNEW = int(max(min($TICKOPT,1.1*$TICKOLD),0.9*$TICKOLD)+0.5);
    printf STDERR "Range limited tick adjustment is %d\n", $TICKNEW
	if $VERBOSE && $TICKNEW != int($TICKOPT+0.5);

    if ($TICKOLD == $TICKNEW) {
	# old/new values same, no adjustment required
	printf STDERR "No tick adjustment required\n" if $VERBOSE;
    } elsif (!$CHECKONLY) {
	# update the tickadj value, if different
    	$TICKEND = get_tickadj($TICKNEW);
    	printf STDERR "Updated tick adjustment is %d\n", $TICKEND if $VERBOSE;
	printf STDERR "Error: Failed tickadj; exp=%d, rcv=%d\n", $TICKNEW, $TICKEND
	    if $TICKNEW != $TICKEND;
    }

}

# --------------------------------------------------------------------------------

# After the tickadj update, now recheck the calibration of the clock:
#
#   ntpdate -b server; sleep 3600; ntpdate -b server
#   23 Nov 12:29:50 ntpdate[496]: step time server server offset 0.001564 sec
#   23 Nov 13:29:55 ntpdate[498]: step time server server offset 0.003010 sec

if ($CHECKEND) {

    # set the clock from the ntp server, discard offset
    $OFFSET = get_offset();
    die "Error: no NTP server response from $NTPSERVER" if $OFFSET eq 'N/A';
    printf STDERR "Initial time offset is %f seconds\n", $OFFSET if $VERBOSE;
	   
    # wait a long time...
    printf STDERR "Going to sleep for %d seconds ... ", $INTERVAL if $VERBOSE;
    $DELTA = time();
    sleep($INTERVAL);
    $DELTA = time()-$DELTA;
    printf STDERR "slept for %d seconds\n", $DELTA if $VERBOSE;

    # set the clock from the ntp server, offset is our clock error
    $OFFSET = get_offset();
    die "Error: no NTP server response from $NTPSERVER" if $OFFSET eq 'N/A';
    printf STDERR "Final time offset is %f seconds\n", $OFFSET if $VERBOSE;

}

# --------------------------------------------------------------------------------

exit;

##################################################################################

# return time offset from ntp server, or N/A if not available

sub get_offset { # ()

    foreach my $k (1..$RETRYCOUNT) {
    	# query the server, check response
    	foreach my $line (`/usr/sbin/ntpdate -b $NTPSERVER`) {
	    printf STDERR "DEBUG: [%s]\n", $line if $DEBUG;
	    # return offset if we get a valid number response
	    return $1 if $line =~ m/\s+offset\s+(-?\d+[.]\d+)\s+sec\s*$/i;
    	}
    	# no response, retry with exponential delay
    	printf STDERR "Error: no response from server %s, will retry in %d sec\n",
    		$NTPSERVER, $RETRYDELAY*2**($k-1) if $VERBOSE;
    	sleep($RETRYDELAY*2**($k-1));
    }
    # whoops, no response at all
    return 'N/A';

}

##################################################################################

# return system tick adj value, set it if non-blank argument supplied

sub get_tickadj { # ($)

    my ($tick) = @_;
    $tick = '' unless defined($tick);

    foreach my $line (`/usr/bin/tickadj $tick`) {
	printf STDERR "DEBUG: [%s]\n", $line if $DEBUG;
	return $1 if $line =~ m/^tick\s+=\s+(\d+)\s*$/i;
    }
    # whoops, tickadj failed
    return -1;

}

##################################################################################

sub min { my ($a,$b) = @_; return $a <= $b ? $a : $b; }

sub max { my ($a,$b) = @_; return $a >= $b ? $a : $b; }

##################################################################################

# the end
