# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Dumpvalue/perl-Dumpvalue-1.170.0-r1.ebuild,v 1.2 2014/03/20 15:12:21 jer Exp $

DESCRIPTION="Virtual for perl-core/Dumpvalue"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

DEPEND=""
RDEPEND="
|| (
		=dev-lang/perl-5.18*
		=dev-lang/perl-5.16*
		~perl-core/Dumpvalue-${PV}
)
"
