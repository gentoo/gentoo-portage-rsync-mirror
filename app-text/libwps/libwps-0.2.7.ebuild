# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwps/libwps-0.2.7.ebuild,v 1.6 2012/12/08 12:29:59 maekke Exp $

EAPI=4

inherit base

DESCRIPTION="Microsoft Works file word processor format import filter library"
HOMEPAGE="http://libwps.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="doc debug static-libs"

RDEPEND="
	app-text/libwpd:0.9
	dev-libs/boost
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

src_configure() {
	econf \
		--disable-werror \
		$(use_enable static-libs static) \
		--docdir=/usr/share/doc/${PF} \
		$(use_with doc docs) \
		$(use_enable debug)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
