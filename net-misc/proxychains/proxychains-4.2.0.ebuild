# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/proxychains/proxychains-4.2.0.ebuild,v 1.4 2013/02/14 22:13:41 ago Exp $

EAPI=5

inherit vcs-snapshot toolchain-funcs eutils multilib

DESCRIPTION="force any tcp connections to flow through a proxy (or proxy chain)"
HOMEPAGE="http://proxychains.sourceforge.net/ https://github.com/haad/proxychains"
SRC_URI="https://github.com/haad/proxychains/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	sed -i "s/^\(LDSO_SUFFIX\).*/\1 = so.${PV}/" Makefile || die
	tc-export CC
}

src_configure() {
	# not autotools
	./configure || die
}

src_install() {
	dobin ${PN}
	dodoc AUTHORS ChangeLog README TODO

	dolib.so lib${PN}.so.${PV}
	dosym lib${PN}.so.${PV} /usr/$(get_libdir)/lib${PN}.so.${PV:0:1}
	dosym lib${PN}.so.${PV} /usr/$(get_libdir)/lib${PN}.so

	insinto /etc
	doins src/${PN}.conf
}
