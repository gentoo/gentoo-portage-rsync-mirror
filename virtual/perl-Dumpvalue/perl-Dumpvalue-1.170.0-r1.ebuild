# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Dumpvalue/perl-Dumpvalue-1.170.0-r1.ebuild,v 1.9 2014/04/24 17:48:15 zlogene Exp $

DESCRIPTION="Virtual for perl-core/Dumpvalue"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="
|| (
		=dev-lang/perl-5.18*
		=dev-lang/perl-5.16*
		~perl-core/Dumpvalue-${PV}
)
"
