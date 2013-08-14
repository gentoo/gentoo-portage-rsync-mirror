# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Dumpvalue/perl-Dumpvalue-1.170.0-r1.ebuild,v 1.1 2013/08/14 04:10:58 patrick Exp $

DESCRIPTION="Virtual for perl-core/Dumpvalue"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="
|| (
		=dev-lang/perl-5.18*
		=dev-lang/perl-5.16*
		~perl-core/Dumpvalue-${PV}
)
"
