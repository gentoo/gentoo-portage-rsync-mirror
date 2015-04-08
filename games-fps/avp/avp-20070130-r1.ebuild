# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/avp/avp-20070130-r1.ebuild,v 1.6 2015/03/14 18:08:19 mgorny Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Linux port of Aliens vs Predator"
HOMEPAGE="http://www.icculus.org/avp/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="AvP"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/openal
	media-libs/libsdl
	amd64? ( app-emulation/emul-linux-x86-sdl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-gcc42.patch \
		"${FILESDIR}"/${P}-glibc2.10.patch
	sed -i \
		-e '/^CC /s:=:?=:' \
		-e '/^CXX /s:=:?=:' \
		-e "/^CFLAGS/s/-g.*/${CFLAGS}/" \
		-e "/^LDLIBS/s/$/${LDFLAGS}/" \
		-e 's:openal-config:pkg-config openal:' \
		Makefile \
		|| die "sed failed"
}

src_install() {
	newgamesbin AvP.bin AvP || die "newgamesbin failed"
	dodoc README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "please follow the instructions in"
	elog "/usr/share/doc/${PF}"
	elog "to install the rest of the game"
}
