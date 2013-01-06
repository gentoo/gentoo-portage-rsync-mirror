# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gens/gens-2.15.5.ebuild,v 1.7 2011/09/21 21:17:48 mr_bones_ Exp $

EAPI=2
inherit eutils flag-o-matic games

DESCRIPTION="A Sega Genesis/CD/32X emulator"
HOMEPAGE="http://sourceforge.net/projects/gens/"
SRC_URI="mirror://sourceforge/gens/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl
	>=media-libs/libsdl-1.2[joystick,video]
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

src_prepare() {
	epatch "${FILESDIR}"/${P}-romsdir.patch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-ovflfix.patch
	sed -i -e '1i#define OF(x) x' src/gens/util/file/unzip.h || die
	append-ldflags -Wl,-z,noexecstack
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS README
	prepgamesdirs
}
