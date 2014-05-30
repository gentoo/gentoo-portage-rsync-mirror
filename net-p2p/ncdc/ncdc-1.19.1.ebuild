# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ncdc/ncdc-1.19.1.ebuild,v 1.2 2014/05/30 12:53:02 xmw Exp $

EAPI=5

inherit autotools eutils toolchain-funcs

DESCRIPTION="ncurses directconnect client"
HOMEPAGE="http://dev.yorhel.nl/ncdc"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="geoip"

RDEPEND="app-arch/bzip2
	dev-db/sqlite:3
	dev-libs/glib:2
	net-libs/gnutls
	sys-libs/ncurses:5[unicode]
	sys-libs/zlib
	geoip? ( dev-libs/geoip )"
DEPEND="${RDEPEND}
	dev-util/makeheaders
	virtual/pkgconfig"

src_prepare() {
	epatch_user && eautoreconf
}

src_configure() {
	econf \
		$(use_with geoip)
}

src_compile() {
	emake AR="$(tc-getAR)"
}
