# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-AuthTicket/Apache-AuthTicket-0.900.0.ebuild,v 1.3 2012/03/08 11:47:27 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=MSCHOUT
MODULE_VERSION=0.90
inherit perl-module

DESCRIPTION="Cookie based access module."

LICENSE="|| ( Artistic-2 GPL-1 GPL-2 GPL-3 )" # GPL-1+
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-perl/Apache-AuthCookie-3.0
	dev-perl/DBI
	virtual/perl-Digest-MD5
	dev-perl/SQL-Abstract"
DEPEND="${RDEPEND}"

SRC_TEST="do"
