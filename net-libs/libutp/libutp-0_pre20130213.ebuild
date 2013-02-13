# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libutp/libutp-0_pre20130213.ebuild,v 1.1 2013/02/13 20:06:49 ssuominen Exp $

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
	# TODO: Build shared library too!

	sed -i \
		-e "s:g++:$(tc-getCXX):" \
		-e '/^CXXFLAGS/s:=:+=:' \
		-e 's:-Wall:& $(CFLAGS):' \
		Makefile || die

	sed -i \
		-e "s:g++:$(tc-getCXX):" \
		-e 's:-Wall:$(LDFLAGS) $(CXXFLAGS) &:' \
		utp_{file,test}/Makefile || die
}

src_compile() {
	local d
	for d in . utp_file utp_test; do
		emake -C ${d}
	done
}

src_install() {
	dolib.a ${PN}.a
	dodoc README.md

	dobin utp_file/utp_{recv,send} utp_test/utp_test
}
