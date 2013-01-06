# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Server-Mail/Net-Server-Mail-0.170.0.ebuild,v 1.3 2011/11/25 23:35:04 hwoarang Exp $

EAPI=4

MODULE_AUTHOR=GUIMARD
MODULE_VERSION=0.17
inherit perl-module

DESCRIPTION="Class to easily create a mail server"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	virtual/perl-libnet
"
DEPEND="${RDEPEND}
"

SRC_TEST=network
