# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/oww/oww-0.82.1.ebuild,v 1.3 2012/05/04 07:50:52 jdhore Exp $

EAPI="3"
DESCRIPTION="A one-wire weather station for Dallas Semiconductor"
HOMEPAGE="http://oww.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
IUSE="gtk nls usb"
KEYWORDS="~amd64 ~x86"

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

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
}
