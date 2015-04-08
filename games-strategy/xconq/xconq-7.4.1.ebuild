# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/xconq/xconq-7.4.1.ebuild,v 1.18 2015/03/31 20:01:35 tupone Exp $

EAPI=5

inherit eutils games

DESCRIPTION="a general strategy game system"
HOMEPAGE="http://sources.redhat.com/xconq/"
SRC_URI="ftp://sources.redhat.com/pub/xconq/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
RESTRICT="test"

DEPEND="
	x11-libs/libXmu
	x11-libs/libXaw
	dev-lang/tk:0
	dev-lang/tcl:0"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-gcc-3.4.patch
	"${FILESDIR}"/${PN}-tkconq.patch
	"${FILESDIR}"/${PN}-make-382.patch
	)

src_configure() {
	egamesconf \
		--enable-alternate-scoresdir="${GAMES_STATEDIR}"/${PN}
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		datadir="${GAMES_DATADIR}"/${PN}
}

src_install() {
	dogamesbin x11/{imf2x,x2imf,xconq,ximfapp}

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r images lib tcltk/*.tcl
	rm -f "${D}/${GAMES_DATADIR}"/${PN}/{images,lib}/{m,M}ake*

	dodir "${GAMES_STATEDIR}"/${PN}
	touch "${D}/${GAMES_STATEDIR}"/${PN}/scores.xcq
	fperms 660 "${GAMES_STATEDIR}"/${PN}/scores.xcq

	doman x11/${PN}.6
	dodoc ChangeLog NEWS README
	prepgamesdirs
}
