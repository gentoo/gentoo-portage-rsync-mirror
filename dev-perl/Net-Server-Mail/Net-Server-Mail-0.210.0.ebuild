# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Server-Mail/Net-Server-Mail-0.210.0.ebuild,v 1.1 2013/09/13 04:50:56 patrick Exp $

EAPI=4

MODULE_AUTHOR=GUIMARD
MODULE_VERSION=0.21
inherit perl-module

DESCRIPTION="Class to easily create a mail server"

LICENSE="|| ( LGPL-2.1 LGPL-3 )" # LGPL-2.1+
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	virtual/perl-libnet
"
DEPEND="${RDEPEND}
"

SRC_TEST=network
