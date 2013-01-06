# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/xmille/xmille-2.0-r1.ebuild,v 1.13 2010/10/12 04:54:39 mr_bones_ Exp $

EAPI=2
inherit eutils games

DEB_PATCH_VER="12"
DESCRIPTION="Mille Bournes card game"
HOMEPAGE="http://www.milleborne.info/"
SRC_URI="mirror://debian/pool/main/x/xmille/${PN}_${PV}.orig.tar.gz
	mirror://debian/pool/main/x/xmille/${PN}_${PV}-${DEB_PATCH_VER}.diff.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libXext"
DEPEND="${RDEPEND}
	app-text/rman
	x11-misc/imake"

S=${WORKDIR}/${P}.orig

PATCHES=( "${WORKDIR}"/${PN}_${PV}-${DEB_PATCH_VER}.diff )

src_configure() {
	xmkmf
}

src_compile() {
	emake -j1 EXTRA_LDOPTIONS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dogamesbin xmille || die "dogamesbin failed"
	dodoc CHANGES README
	newman xmille.man xmille.6
	prepgamesdirs
}
