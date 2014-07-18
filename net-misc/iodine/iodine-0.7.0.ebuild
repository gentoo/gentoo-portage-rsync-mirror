# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/iodine/iodine-0.7.0.ebuild,v 1.1 2014/07/18 15:53:52 xmw Exp $

EAPI=5

inherit linux-info eutils toolchain-funcs

DESCRIPTION="IP over DNS tunnel"
HOMEPAGE="http://code.kryo.se/iodine/"
SRC_URI="http://code.kryo.se/${PN}/${P}.tar.gz"

CONFIG_CHECK="~TUN"

LICENSE="ISC GPL-2" #GPL-2 for init script bug #426060
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	test? ( dev-libs/check )"

src_prepare(){
	epatch "${FILESDIR}"/${P}-TestMessage.patch

	sed -e '/^\s@echo \(CC\|LD\)/d' \
		-e 's:^\(\s\)@:\1:' \
		-i {,src/}Makefile || die

	tc-export CC
}

src_compile() {
	#shipped ./Makefiles doesn't pass -j<n> to submake
	emake -C src TARGETOS=Linux all
}

src_install() {
	#don't re-run submake
	sed -e '/^install:/s: all: :' \
		-i Makefile || die
	emake prefix="${EPREFIX}"usr DESTDIR="${D}" install

	dodoc CHANGELOG README TODO

	newinitd "${FILESDIR}"/iodined-1.init iodined
	newconfd "${FILESDIR}"/iodined.conf iodined
	keepdir /var/empty
}
