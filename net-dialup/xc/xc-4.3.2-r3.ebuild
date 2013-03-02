# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xc/xc-4.3.2-r3.ebuild,v 1.3 2013/03/02 18:01:12 pinkbyte Exp $

EAPI=5

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="unix dialout program"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/serialcomm/dialout/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/serialcomm/dialout/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-implicit-decl.patch
	epatch "${FILESDIR}"/${P}-add-115200.patch

	sed -i \
		-e "/^libdir/s:/lib/:/$(get_libdir)/:" \
		Makefile || die
	# bug 459796
	append-libs "$($(tc-getPKG_CONFIG) --libs ncurses)"
}

src_compile() {
	tc-export AR CC RANLIB
	emake WARN="" all
}

src_install() {
	default
	insinto /usr/$(get_libdir)/xc
	doins phonelist xc.init dotfiles/.[a-z]*
}
