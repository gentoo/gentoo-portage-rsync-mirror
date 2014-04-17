# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/dia2code/dia2code-0.8.5.ebuild,v 1.9 2014/04/17 07:44:55 pacho Exp $

EAPI=5
GCONF_DEBUG="no"

inherit autotools eutils flag-o-matic gnome2

DESCRIPTION="Convert UML diagrams produced with Dia to various source code flavours"
HOMEPAGE="http://dia2code.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-libs/libxml2"
RDEPEND="${DEPEND}
	>=app-office/dia-0.90.0
"

src_prepare() {
	# Respect AR, bug #462968
	epatch "${FILESDIR}/${PN}-0.8.5-ar.patch"

	sed -i -e 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.in || die

	eautoreconf # Needed to prevent maintainer-mode to get activated
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install
	doman dia2code.1
}
