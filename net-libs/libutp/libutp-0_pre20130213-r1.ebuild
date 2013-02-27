# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libutp/libutp-0_pre20130213-r1.ebuild,v 1.3 2013/02/27 16:21:53 ssuominen Exp $

EAPI=5
inherit toolchain-funcs

DESCRIPTION="uTorrent Transport Protocol library"
HOMEPAGE="http://github.com/bittorrent/libutp"
SRC_URI="http://dev.gentoo.org/~ssuominen/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	sed -i \
		-e 's:g++:$(CXX):' \
		-e 's:-Wall:$(LDFLAGS) $(CXXFLAGS) &:' \
		utp_{file,test}/Makefile || die

	cp -f "${FILESDIR}"/Makefile .
}

src_compile() {
	tc-export AR CXX RANLIB
	local d
	for d in . utp_file utp_test; do
		emake -C ${d}
	done
}

src_install() {
	dolib.a ${PN}.a
	dolib.so ${PN}.so*

	insinto /usr/include/${PN}
	doins {utp,utypes}.h

	dobin utp_file/utp_{recv,send} utp_test/utp_test

	dodoc README.md
}
