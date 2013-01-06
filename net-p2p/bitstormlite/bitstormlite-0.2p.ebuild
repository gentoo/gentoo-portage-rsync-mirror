# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bitstormlite/bitstormlite-0.2p.ebuild,v 1.6 2012/05/04 06:33:35 jdhore Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A light BitTorrent client based on c++ and gtk+."
HOMEPAGE="http://sourceforge.net/projects/bbom/"
SRC_URI="mirror://sourceforge/bbom/BitStormLite-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	>=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/BitStormLite-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
}
