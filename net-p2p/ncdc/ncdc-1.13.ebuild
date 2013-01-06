# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ncdc/ncdc-1.13.ebuild,v 1.4 2012/10/17 03:33:35 phajdan.jr Exp $

EAPI=4

DESCRIPTION="ncurses directconnect client"
HOMEPAGE="http://dev.yorhel.nl/ncdc"
SRC_URI="http://dev.yorhel.nl/download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="+db-upgrade"

RDEPEND="app-arch/bzip2
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-util/makeheaders
	net-libs/gnutls
	sys-libs/ncurses:5
	sys-libs/zlib
	db-upgrade? (
		dev-libs/libxml2:2
		sys-libs/gdbm
	)"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable db-upgrade)
}
