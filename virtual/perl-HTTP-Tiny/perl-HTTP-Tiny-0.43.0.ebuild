# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-HTTP-Tiny/perl-HTTP-Tiny-0.43.0.ebuild,v 1.3 2015/02/13 10:26:45 ago Exp $

EAPI=5

DESCRIPTION="Virtual for HTTP-Tiny"
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
