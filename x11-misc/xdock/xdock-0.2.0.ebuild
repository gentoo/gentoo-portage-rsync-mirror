# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdock/xdock-0.2.0.ebuild,v 1.3 2010/10/26 12:28:16 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="emulates Window Maker docks (runs in any window manager)"
HOMEPAGE="http://xdock.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	media-libs/imlib"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ldconfig.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc API AUTHORS ChangeLog README TODO
}
