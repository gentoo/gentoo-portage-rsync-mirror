# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/createtorrent/createtorrent-1.1.3-r1.ebuild,v 1.1 2007/04/13 19:16:06 drac Exp $

inherit autotools eutils

DESCRIPTION="Create BitTorrent files easily"
HOMEPAGE="http://www.createtorrent.com/"
SRC_URI="http://www.createtorrent.com/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README
}
