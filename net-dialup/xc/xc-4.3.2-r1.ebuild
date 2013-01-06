# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/xc/xc-4.3.2-r1.ebuild,v 1.19 2011/02/06 07:53:42 leio Exp $

inherit eutils toolchain-funcs

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
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-implicit-decl.patch"

	# Adds 115200 bps support
	epatch "${FILESDIR}/${P}-add-115200.patch"
}

src_compile() {
	tc-export CC
	emake WARN="" all prefix=/usr mandir=/usr/share/man || die "make failed"
}

src_install () {
	dodir /usr/bin /usr/share/man/man1 /usr/lib/xc

	make DESTDIR="${D}" install || die "make install failed"

	insinto /usr/lib/xc
	doins phonelist xc.init dotfiles/.[a-z]*
}
