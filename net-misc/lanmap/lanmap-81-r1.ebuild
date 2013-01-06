# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lanmap/lanmap-81-r1.ebuild,v 1.3 2012/04/14 19:03:38 zmedico Exp $

EAPI=3

inherit toolchain-funcs eutils

DESCRIPTION="lanmap sits quietly on a network and builds a picture of what it sees"
HOMEPAGE="http://www.parseerror.com/lanmap"
SRC_URI="http://www.parseerror.com/${PN}/rev/${PN}-2006-03-07-rev${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="net-libs/libpcap
	 media-gfx/graphviz"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/makefile.patch
	sed -e 's:install -m 0644 -d:install -m 0755 -d:' -i Makefile.in || die
	chmod +x configure || die
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" || die
}

src_install() {
	emake prefix="${ED}"/usr install || die
	dodoc {README,TODO}.txt || die
}
