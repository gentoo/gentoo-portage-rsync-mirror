# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xc/xc-4.3.2-r2.ebuild,v 1.2 2011/03/21 00:37:24 vapier Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="unix dialout program"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/apps/serialcomm/dialout/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/serialcomm/dialout/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gentoo.patch
	epatch "${FILESDIR}"/${P}-implicit-decl.patch
	epatch "${FILESDIR}"/${P}-add-115200.patch

	sed -i \
		-e "/^libdir/s:/lib/:/$(get_libdir)/:" \
		Makefile || die
}

src_compile() {
	tc-export CC
	emake WARN="" all || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	insinto /usr/$(get_libdir)/xc
	doins phonelist xc.init dotfiles/.[a-z]* || die
}
