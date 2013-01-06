# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flowgrind/flowgrind-0.5.8.ebuild,v 1.4 2012/08/22 00:42:56 flameeyes Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="Network performance measurement tool"
HOMEPAGE="https://launchpad.net/flowgrind"
SRC_URI="https://launchpad.net/${PN}/trunk/${P}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gsl pcap"

RDEPEND="dev-libs/xmlrpc-c[abyss,curl]
	gsl? ( sci-libs/gsl )
	pcap? ( net-libs/libpcap )"
DEPEND="${RDEPEND}"

src_prepare() {
	# see https://github.com/gentoo/flowgrind/tree/flowgrind-0.5.8-gentoo
	epatch "${FILESDIR}"/${P}-gentoo.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable gsl) \
		$(use_enable pcap)
}
