# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/guichan/guichan-0.8.2.ebuild,v 1.7 2013/04/27 23:10:19 hasufell Exp $

EAPI=2
inherit eutils autotools

DESCRIPTION="a portable C++ GUI library designed for games using Allegro, SDL and/or OpenGL"
HOMEPAGE="http://guichan.sourceforge.net/"
SRC_URI="http://guichan.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="allegro opengl sdl static-libs"

DEPEND="allegro? ( <media-libs/allegro-5 )
	opengl? ( virtual/opengl )
	sdl? (
		media-libs/libsdl
		media-libs/sdl-image
	)"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-automake-1.13.patch
	mv configure.in configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable allegro) \
		$(use_enable opengl) \
		$(use_enable sdl) \
		$(use_enable sdl sdlimage) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	if ! use static-libs ; then
		find "${D}" -type f -name '*.la' -exec rm {} + \
			|| die "la removal failed"
	fi
}
