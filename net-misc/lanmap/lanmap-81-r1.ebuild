# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lanmap/lanmap-81-r1.ebuild,v 1.5 2013/09/26 01:29:27 zerochaos Exp $

EAPI=5

inherit toolchain-funcs eutils

DESCRIPTION="lanmap sits quietly on a network and builds a picture of what it sees"
HOMEPAGE="http://www.parseerror.com/lanmap"
SRC_URI="http://www.parseerror.com/${PN}/rev/${PN}-2006-03-07-rev${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE=""

RDEPEND="net-libs/libpcap
	 media-gfx/graphviz"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/makefile.patch
	sed -e 's:install -m 0644 -d:install -m 0755 -d:' -i Makefile.in || die
	chmod +x configure || die
}

src_compile() {
	emake -j1 CC="$(tc-getCC)"
}

src_install() {
	emake prefix="${ED}"/usr install
	dodoc {README,TODO}.txt
}
