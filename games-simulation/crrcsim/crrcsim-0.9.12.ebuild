# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/crrcsim/crrcsim-0.9.12.ebuild,v 1.3 2012/12/21 03:08:34 mr_bones_ Exp $

EAPI=4
WANT_AUTOMAKE="1.10"
inherit autotools eutils games

DESCRIPTION="model-airplane flight simulation program"
HOMEPAGE="http://sourceforge.net/projects/crrcsim/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="portaudio"

RDEPEND="sci-mathematics/cgal
	media-libs/plib
	media-libs/libsdl[X,audio,joystick,opengl,video]
	portaudio? ( media-libs/portaudio )"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-buildsystem.patch
	if has_version "sci-mathematics/cgal[gmp(+)]" ; then
		epatch "${FILESDIR}"/${PN}-cgal_gmp.patch
	fi
	eautoreconf
}

src_configure() {
	econf --docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_with portaudio)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS HISTORY NEWS README
	prepgamesdirs
}
