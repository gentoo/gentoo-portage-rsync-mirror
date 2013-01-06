# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/suxpanel/suxpanel-0.4b-r3.ebuild,v 1.5 2012/05/05 04:53:53 jdhore Exp $

EAPI=2
inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="SuxPanel is a complete rewrite of MacOS Style Panel, a light-weight X11 desktop panel"
HOMEPAGE="http://suxpanel.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libwnck:1"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-stdlib.patch \
		"${FILESDIR}"/${P}-makefile.patch

	sed -i \
		-e "s:share/${PN}/plugins:$(get_libdir)/${PN}/plugins:" \
		Makefile.in suxpanel-install.sh || die
}

src_configure() {
	use amd64 && append-flags -O0
	tc-export CC
	econf
}

src_install () {
	emake DESTDIR="${D}" install || die
	dobin suxpanel-install.sh || die
	dodoc README || die
}
