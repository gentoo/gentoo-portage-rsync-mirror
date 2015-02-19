# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/gslist/gslist-0.8.8a.ebuild,v 1.4 2015/02/19 10:06:50 mr_bones_ Exp $

EAPI=5
inherit eutils games

DESCRIPTION="A GameSpy server browser"
HOMEPAGE="http://aluigi.altervista.org/papers.htm#gslist"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa x86"
IUSE="web"

RDEPEND="dev-libs/geoip"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${PN}

src_prepare() {
	emake clean
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	emake SQL=0 $(use web || echo GSWEB=0)
}

src_install() {
	dogamesbin ${PN}
	dodoc ${PN}.txt
	prepgamesdirs
}
