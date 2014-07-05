# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-CPAN/perl-CPAN-2.0.5.ebuild,v 1.1 2014/07/05 11:36:53 dilfridge Exp $

EAPI=5

DESCRIPTION="Virtual for CPAN"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( =dev-lang/perl-5.20* ~perl-core/CPAN-${PV} )"
