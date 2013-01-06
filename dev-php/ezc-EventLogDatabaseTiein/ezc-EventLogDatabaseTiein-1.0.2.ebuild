# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/ezc-EventLogDatabaseTiein/ezc-EventLogDatabaseTiein-1.0.2.ebuild,v 1.1 2011/12/14 22:08:31 mabi Exp $

EZC_BASE_MIN="1.2"
inherit php-ezc

DESCRIPTION="This eZ component contains the database writer backend for the EventLog component."
SLOT="0"
KEYWORDS="~amd64 ~hppa ~sparc ~x86"
IUSE=""
RDEPEND="${RDEPEND}
	>=dev-php/ezc-Database-1.2
	>=dev-php/ezc-EventLog-1.0.3"
