# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Filter-Simple/perl-Filter-Simple-0.910.0.ebuild,v 1.4 2015/02/13 22:05:40 jer Exp $

EAPI=5

DESCRIPTION="Virtual for perl-core/Filter-Simple"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 hppa x86"
IUSE=""

DEPEND=""
RDEPEND="
	|| ( =dev-lang/perl-5.20* ~perl-core/${PN#perl-}-${PV} )
	!<perl-core/${PN#perl-}-${PV}
	!>perl-core/${PN#perl-}-${PV}-r999
"
