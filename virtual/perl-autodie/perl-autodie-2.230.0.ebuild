# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-autodie/perl-autodie-2.230.0.ebuild,v 1.3 2015/02/13 10:27:59 ago Exp $

EAPI=5

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	|| ( =dev-lang/perl-5.20* ~perl-core/${PN#perl-}-${PV} )
	!<perl-core/${PN#perl-}-${PV}
	!>perl-core/${PN#perl-}-${PV}-r999
"
