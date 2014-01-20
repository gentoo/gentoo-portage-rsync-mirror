# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Test/perl-Test-1.250.200_rc-r1.ebuild,v 1.2 2014/01/20 20:45:58 vapier Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* =dev-lang/perl-5.14* =dev-lang/perl-5.12* ~perl-core/${PN#perl-}-${PV}  )"
