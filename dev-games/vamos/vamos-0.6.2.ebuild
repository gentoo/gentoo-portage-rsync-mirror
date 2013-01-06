# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/vamos/vamos-0.6.2.ebuild,v 1.8 2012/05/03 06:35:31 jdhore Exp $

EAPI=2
inherit eutils

DESCRIPTION="an automotive simulation framework"
HOMEPAGE="http://vamos.sourceforge.net/"
SRC_URI="mirror://sourceforge/vamos/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="static-libs"

RDEPEND="virtual/opengl
	media-libs/freeglut
	media-libs/libpng
	media-libs/libsdl[joystick,video]
	media-libs/openal
	media-libs/freealut"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-libpng15.patch
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-unit-tests \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dobin caelum/.libs/caelum || die "dobin failed"
	newdoc caelum/README README.caelum
	dodoc AUTHORS ChangeLog README TODO
	if ! use static-libs ; then
		find "${D}" -type f -name '*.la' -exec rm {} + \
			|| die "la removal failed"
	fi
}
