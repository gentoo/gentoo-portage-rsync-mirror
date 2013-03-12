# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/oww/oww-0.86.2.ebuild,v 1.1 2013/03/12 12:18:16 jlec Exp $

EAPI=5

DESCRIPTION="A one-wire weather station for Dallas Semiconductor"
HOMEPAGE="http://oww.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~x86"
IUSE="gtk nls usb"

RDEPEND="
	net-misc/curl
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i \
		-e "s:doc/oww:share/doc/${PF}/:" \
		-e '/COPYING\\/d' \
		-e '/INSTALL\\/d' \
		Makefile.in || die "Failed to fix doc install path"
}

src_configure() {
	econf \
		--enable-interactive \
		$(use_enable nls) \
		$(use_enable gtk gui) \
		$(use_with usb)
}
