# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Exporter/perl-Exporter-5.700.0.ebuild,v 1.3 2014/09/13 19:27:38 dilfridge Exp $

EAPI=5

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	|| ( =dev-lang/perl-5.20.0* ~perl-core/${PN#perl-}-${PV} )
	!<perl-core/${PN#perl-}-${PV}
	!>perl-core/${PN#perl-}-${PV}-r999
"
