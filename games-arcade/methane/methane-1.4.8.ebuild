# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/methane/methane-1.4.8.ebuild,v 1.9 2012/05/04 04:22:28 jdhore Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Port from an old amiga game"
HOMEPAGE="http://methane.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+mikmod"

RDEPEND="dev-games/clanlib:0.8[opengl]
	mikmod? ( media-libs/libmikmod )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	if ! use mikmod ; then
		sed -i \
			-e '/^METHANE_SND/s/^/#/' \
			source/linux/makefile \
			|| die "sed failed"
	fi
	sed -i \
		-e "s:/var/games:${GAMES_STATEDIR}:" \
		source/linux/doc.cpp \
		|| die "sed failed"
	epatch "${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-gcc46.patch
}

src_compile() {
	emake -C source/linux || die "emake failed"
}

src_install() {
	dogamesbin source/linux/methane || die "dogamesbin failed"
	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}"/methanescores
	fperms g+w "${GAMES_STATEDIR}"/methanescores
	newicon docs/puff.gif ${PN}.gif
	make_desktop_entry ${PN} "Super Methane Brothers" /usr/share/pixmaps/${PN}.gif
	dodoc authors history readme todo
	dohtml docs/*
	prepgamesdirs
}
