# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptstate/iptstate-2.2.3.ebuild,v 1.4 2012/02/05 18:25:50 armin76 Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="IP Tables State displays states being kept by iptables in a top-like format"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.phildev.net/iptstate/"

DEPEND="sys-libs/ncurses
	>=net-libs/libnetfilter_conntrack-0.0.50"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 ~hppa ~ppc x86"
IUSE=""

src_prepare() {
	sed -i Makefile \
		-e 's|$(CXXFLAGS)|& $(LDFLAGS)|g' \
		|| die "sed failed"
}

src_compile() {
	emake CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	emake PREFIX="${D}"/usr install || die
	dodoc README Changelog BUGS CONTRIB WISHLIST
}
