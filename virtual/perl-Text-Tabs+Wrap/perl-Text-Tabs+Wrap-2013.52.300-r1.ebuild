# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Text-Tabs+Wrap/perl-Text-Tabs+Wrap-2013.52.300-r1.ebuild,v 1.1 2014/07/13 18:42:52 dilfridge Exp $

EAPI=5

DESCRIPTION="Virtual for Text::Tabs and Text::Wrap, also distributed as Text::Tabs+Wrap"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="
	|| ( =dev-lang/perl-5.20* ~perl-core/${PN#perl-}-${PV} )
	!<perl-core/${PN#perl-}-${PV}
	!>perl-core/${PN#perl-}-${PV}-r999
"
