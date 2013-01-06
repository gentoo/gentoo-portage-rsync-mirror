# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fragroute/fragroute-1.2-r4.ebuild,v 1.1 2012/10/09 09:09:01 pinkbyte Exp $

EAPI="4"

inherit base eutils toolchain-funcs

DESCRIPTION="Testing of network intrusion detection systems, firewalls and TCP/IP stacks"
HOMEPAGE="http://www.monkey.org/~dugsong/fragroute/"
SRC_URI="http://www.monkey.org/~dugsong/fragroute/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	dev-libs/libevent
	net-libs/libpcap
	>=dev-libs/libdnet-1.4
"
DEPEND="${RDEPEND}
	virtual/awk"

DOCS="INSTALL README TODO"

PATCHES=( "${FILESDIR}"/${PV}-libevent.patch )

src_prepare() {
	base_src_prepare
	sed -i configure \
		-e 's|libevent.a|libevent.so|g' \
		|| die "sed configure.in"
	tc-export CC
}

src_configure() {
	econf \
		--with-libevent="${EPREFIX}"/usr \
		--with-libdnet="${EPREFIX}"/usr \
		--with-pcap="${EPREFIX}"/usr
}
