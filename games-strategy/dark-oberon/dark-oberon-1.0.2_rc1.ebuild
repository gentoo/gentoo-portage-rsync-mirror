# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/dark-oberon/dark-oberon-1.0.2_rc1.ebuild,v 1.5 2015/02/18 19:11:30 mr_bones_ Exp $

EAPI=5
inherit eutils games

MY_PV=${PV/_rc/-RC}
MY_P=${PN}-${MY_PV}

DESCRIPTION="a Warcraft like RTS game"
HOMEPAGE="http://dark-oberon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="fmod"

DEPEND="virtual/opengl
	virtual/glu
	media-libs/glfw
	fmod? ( =media-libs/fmod-3* )"

S=${WORKDIR}/${MY_P}

PATCHES=(
)

src_prepare() {
	epatch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-gentoo.patch \
		"${FILESDIR}"/${P}-ldflags.patch
}

src_compile() {
	emake -C src $(use fmod && echo "SOUND=1") ../${PN}
}

src_install() {
	dogamesbin dark-oberon

	insinto "${GAMES_DATADIR}/${PN}"
	doins -r dat maps races schemes
	dodoc README docs/*

	prepgamesdirs
}
