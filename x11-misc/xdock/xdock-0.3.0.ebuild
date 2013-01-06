# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdock/xdock-0.3.0.ebuild,v 1.1 2012/02/13 22:17:46 voyageur Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="emulates Window Maker docks (runs in any window manager)"
HOMEPAGE="http://xdock.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.2.0-ldconfig.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc API AUTHORS ChangeLog README TODO
}
