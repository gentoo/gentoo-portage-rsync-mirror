# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/packETH/packETH-1.7.3.ebuild,v 1.1 2014/07/18 20:17:37 jer Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Packet generator tool for ethernet"
HOMEPAGE="http://packeth.sourceforge.net/"
SRC_URI="mirror://sourceforge/packeth/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:2
"
DEPEND="
	virtual/pkgconfig
	${RDEPEND}
"
DOCS=( AUTHORS CHANGELOG README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${P}-libs-and-flags.patch
	eautoreconf
}
