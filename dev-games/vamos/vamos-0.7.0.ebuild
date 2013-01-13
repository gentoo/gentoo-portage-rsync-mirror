# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/vamos/vamos-0.7.0.ebuild,v 1.3 2013/01/13 11:22:57 ago Exp $

EAPI=4
inherit eutils

DESCRIPTION="an automotive simulation framework"
HOMEPAGE="http://vamos.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="static-libs"

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/freeglut
	media-libs/libpng:0
	media-libs/libsdl[joystick,video]
	media-libs/openal
	media-libs/freealut"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-unit-tests \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install
	dobin caelum/.libs/caelum
	newdoc caelum/README README.caelum
	dodoc AUTHORS ChangeLog README TODO
	prune_libtool_files
}
