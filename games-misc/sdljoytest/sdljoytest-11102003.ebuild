# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/sdljoytest/sdljoytest-11102003.ebuild,v 1.4 2010/11/29 05:08:17 mr_bones_ Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="SDL app to test joysticks and game controllers"
HOMEPAGE="http://sdljoytest.sourceforge.net/"
SRC_URI="mirror://sourceforge/sdljoytest/SDLJoytest-GL-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl[joystick,opengl,video]
	virtual/opengl
	media-libs/sdl-image"

S=${WORKDIR}/SDLJoytest-GL

src_prepare() {
	make clean || die "cleaning"
	sed -i \
		-e 's:/usr/local:/usr:' \
		joytest.h || die "seding data path"
	sed -i -e 's:SDL/::' *.c || die
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="$(sdl-config --cflags) ${CFLAGS}" \
		LDFLAGS="$(sdl-config --libs) -lGL ${LDFLAGS}" \
		|| die
}

src_install() {
	dobin SDLJoytest-GL || die "dobin"
	insinto /usr/share/SDLJoytest-GL
	doins *.bmp || die "data"
	doman SDLJoytest.1
}
