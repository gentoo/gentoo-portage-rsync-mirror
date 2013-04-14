# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/magiccube4d/magiccube4d-2.2.ebuild,v 1.15 2013/04/14 07:06:52 ulm Exp $

EAPI=2
inherit eutils games

MY_PV=${PV/./_}
DESCRIPTION="four-dimensional analog of Rubik's cube"
HOMEPAGE="http://www.superliminal.com/cube/cube.htm"
SRC_URI="http://www.superliminal.com/cube/mc4d-src-${MY_PV}.tgz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/libXaw"

S=${WORKDIR}/${PN}-src-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-EventHandler.patch \
		"${FILESDIR}/${P}"-gcc41.patch \
		"${FILESDIR}/${P}"-64bit-ptr.patch \
		"${FILESDIR}"/${P}-ldflags.patch
	sed -i \
		-e "s:-Werror::" \
		configure \
		|| die "sed failed"
}

src_compile() {
	emake DFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin magiccube4d || die "dogamesbin failed"
	dodoc ChangeLog MagicCube4D-unix.txt readme-unix.txt Intro.txt
	prepgamesdirs
}
