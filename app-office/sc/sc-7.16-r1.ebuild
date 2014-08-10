# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/sc/sc-7.16-r1.ebuild,v 1.8 2014/08/10 18:17:32 slyfox Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="sc is a free curses-based spreadsheet program that uses key bindings similar to vi and less"
SRC_URI="ftp://ibiblio.org/pub/Linux/apps/financial/spreadsheet/${P}.tar.gz"
HOMEPAGE="http://ibiblio.org/pub/Linux/apps/financial/spreadsheet/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"
RDEPEND="${DEPEND}
	!dev-lang/stratego
	!<sci-chemistry/ccp4-apps-6.1.3-r4"
src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i	-e "/^prefix=/ s:/usr:${D}/usr:" \
			-e "/^MANDIR=/ s:${prefix}/man:${prefix}/share/man:" \
			-e "/^LIBDIR=/ s:${prefix}/lib:${prefix}/$(get_libdir):" \
			-e "/^CC=/ s:gcc:$(tc-getCC):" \
			-e "/^CFLAGS/ s:=-DSYSV3 -O2 -pipe:+=-DSYSV3:" \
			-e "/strip/ s:^:#:g" \
			Makefile

	epatch "${FILESDIR}"/${P}-amd64.patch
	epatch "${FILESDIR}"/${P}-lex-syntax.patch
}

src_compile() {
	# no autoconf
	emake prefix="${D}"/usr || die "emake failed"
}

src_install () {
	# yes the makefile is so dumb it can't even make it's own dirs
	dodir /usr/bin
	dodir /usr/$(get_libdir)/sc
	dodir /usr/share/man/man1
	emake install || die

	sed -i "s:${D}::g" sc.1
	doman sc.1 psc.1

	dodoc CHANGES README sc.doc psc.doc tutorial.sc
	dodoc VMS_NOTES ${P}.lsm TODO SC.MACROS
}
