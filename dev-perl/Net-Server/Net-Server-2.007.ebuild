# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Server/Net-Server-2.007.ebuild,v 1.1 2013/02/28 19:12:15 zx2c4 Exp $

EAPI=5

MODULE_AUTHOR=RHANDOM
MODULE_VERSION=${PV}
inherit perl-module

DESCRIPTION="Extensible, general Perl server engine"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	virtual/perl-libnet
"
DEPEND="${RDEPEND}
"
