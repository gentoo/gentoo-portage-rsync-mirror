# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptstate/iptstate-2.2.5.ebuild,v 1.4 2012/09/20 14:00:01 johu Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="IP Tables State displays states being kept by iptables in a top-like format"
HOMEPAGE="http://www.phildev.net/iptstate/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

RDEPEND=">=sys-libs/ncurses-5.7-r7
	>=net-libs/libnetfilter_conntrack-0.0.50"
DEPEND=${RDEPEND}

src_prepare() {
	sed -i \
		-e 's:?= -g -Wall -O2:+= -Wall:' \
		-e '/^CPPFLAGS=/d' \
		-e 's:$(CXX):& $(LDFLAGS):' \
		Makefile || die
}

src_compile() {
	tc-export CXX
	emake
}

src_install() {
	emake PREFIX="${D}"/usr install
	dodoc BUGS Changelog CONTRIB README WISHLIST
}
