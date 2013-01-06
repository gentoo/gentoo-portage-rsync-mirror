# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipsec-tools/files/racoon.conf.d,v 1.4 2012/03/09 02:55:47 blueness Exp $

# Config file for /etc/init.d/racoon

# See the man page or run `racoon --help` for valid command-line options
# RACOON_OPTS="-d"

RACOON_CONF="/etc/racoon/racoon.conf"
RACOON_PSK_FILE="/etc/racoon/psk.txt"
SETKEY_CONF="/etc/ipsec.conf"

# Comment or remove the following if you don't want the policy tables
# to be flushed when racoon is stopped.

RACOON_RESET_TABLES="true"

