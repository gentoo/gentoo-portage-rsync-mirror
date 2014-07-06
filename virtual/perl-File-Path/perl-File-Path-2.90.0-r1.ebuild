# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-File-Path/perl-File-Path-2.90.0-r1.ebuild,v 1.1 2014/07/06 15:35:50 dilfridge Exp $

EAPI=5

DESCRIPTION="Virtual for File-Path"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ~arm ~ia64 ~ppc ~sparc x86 ~ppc-aix"
IUSE=""

RDEPEND="
	|| ( =dev-lang/perl-5.20* =dev-lang/perl-5.18* ~perl-core/${PN#perl-}-${PV} )
	!<perl-core/${PN#perl-}-${PV}
"
