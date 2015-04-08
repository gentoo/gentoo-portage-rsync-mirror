# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcdplay/wmcdplay-1.1.ebuild,v 1.1 2015/01/12 10:48:41 voyageur Exp $

EAPI=5
inherit autotools

DESCRIPTION="CD player applet for WindowMaker"
HOMEPAGE="http://windowmaker.org/dockapps/?name=wmcdplay"
# Grab from http://windowmaker.org/dockapps/?download=${P}.tar.gz
SRC_URI="http://dev.gentoo.org/~voyageur/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXpm"
DEPEND="${RDEPEND}
	x11-proto/xproto"

S=${WORKDIR}/dockapps

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc ARTWORK README
	domenu "${FILESDIR}"/${PN}.desktop
}
