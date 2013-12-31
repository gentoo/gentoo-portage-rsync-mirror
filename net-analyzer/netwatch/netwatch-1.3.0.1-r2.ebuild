# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netwatch/netwatch-1.3.0.1-r2.ebuild,v 1.2 2013/12/23 02:01:36 jer Exp $

EAPI=5

inherit autotools eutils versionator

MY_PV=$(replace_version_separator 3 '-')

DESCRIPTION="Ethernet/PPP IP Packet Monitor"
HOMEPAGE="http://www.slctech.org/~mackay/netwatch.html"
SRC_URI="http://www.slctech.org/~mackay/NETWATCH/${PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-kernel/linux-headers"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-append_ldflags.patch \
		"${FILESDIR}"/${P}-open.patch \
		"${FILESDIR}"/${P}-fix-fortify.patch \
		"${FILESDIR}"/${P}-do-not-call.patch \
		"${FILESDIR}"/${P}-tinfo.patch

	eautoreconf
}

src_install() {
	dosbin netresolv netwatch

	doman netwatch.1
	dodoc BUGS CHANGES README* TODO

	if use doc; then
		dohtml NetwatchKeyCommands.html
	fi
}
