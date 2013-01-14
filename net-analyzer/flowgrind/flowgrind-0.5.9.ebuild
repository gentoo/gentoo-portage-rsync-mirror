# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flowgrind/flowgrind-0.5.9.ebuild,v 1.1 2013/01/14 19:41:28 jer Exp $

EAPI=4

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

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable gsl) \
		$(use_enable pcap)
}
