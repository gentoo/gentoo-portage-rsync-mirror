# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miredo/miredo-1.2.5-r1.ebuild,v 1.1 2012/06/20 06:22:44 xmw Exp $

EAPI=4

inherit autotools eutils linux-info

DESCRIPTION="Miredo is an open-source Teredo IPv6 tunneling software."
HOMEPAGE="http://www.remlab.net/miredo/"
SRC_URI="http://www.remlab.net/files/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+caps"

RDEPEND="sys-apps/iproute2
	dev-libs/judy
	caps? ( sys-libs/libcap )"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

CONFIG_CHECK="~IPV6" #318777

#tries to connect to external networks (#339180)
RESTRICT="test"

DOCS=( AUTHORS ChangeLog NEWS README TODO THANKS )

src_prepare() {
	epatch "${FILESDIR}"/${P}-configure-libcap.diff
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--enable-miredo-user \
		--localstatedir=/var \
		$(use_with caps libcap "${ROOT}usr")
}

src_install() {
	default
	prune_libtool_files

	newinitd "${FILESDIR}"/miredo-server.rc miredo-server
	newconfd "${FILESDIR}"/miredo-server.conf miredo-server
	newinitd "${FILESDIR}"/miredo.rc miredo
	newconfd "${FILESDIR}"/miredo.conf miredo

	insinto /etc/miredo
	doins misc/miredo-server.conf
}

pkg_preinst() {
	enewgroup miredo
	enewuser miredo -1 -1 /var/empty miredo
}
