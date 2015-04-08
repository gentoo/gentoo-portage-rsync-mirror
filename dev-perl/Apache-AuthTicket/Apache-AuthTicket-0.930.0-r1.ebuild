# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Apache-AuthTicket/Apache-AuthTicket-0.930.0-r1.ebuild,v 1.1 2014/08/25 02:19:52 axs Exp $

EAPI=5

MODULE_AUTHOR=MSCHOUT
MODULE_VERSION=0.93
inherit perl-module

DESCRIPTION="Cookie based access module"

LICENSE="|| ( Artistic-2 GPL-1 GPL-2 GPL-3 )" # GPL-1+
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Apache-AuthCookie-3.0
	dev-perl/DBI
	virtual/perl-Digest-MD5
	dev-perl/SQL-Abstract"
DEPEND="${RDEPEND}"

SRC_TEST="do"
