# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Math-BigInt-FastCalc/perl-Math-BigInt-FastCalc-0.300.0-r1.ebuild,v 1.2 2012/09/01 12:13:45 grobian Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* ~perl-core/${PN#perl-}-${PV} )"
