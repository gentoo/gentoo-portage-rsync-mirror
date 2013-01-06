# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/bvi/bvi-1.3.2-r1.ebuild,v 1.1 2013/01/04 09:55:25 ryao Exp $

EAPI=3

inherit multilib eutils

DESCRIPTION="display-oriented editor for binary files, based on the vi texteditor"
HOMEPAGE="http://bvi.sourceforge.net/"
SRC_URI="mirror://sourceforge/bvi/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-buffer-overflow.patch"
	sed -i -e 's:(INSTALL_PROGRAM) -s:(INSTALL_PROGRAM):g' \
		Makefile.in || die "sed failed in Makefile.in"

	epatch_user
}

src_configure() {
	econf --with-ncurses="${EPREFIX}"/usr

	sed -i -e 's:ncurses/term.h:term.h:g' bmore.h || die "sed failed in bmore.h"
}

src_install() {
	einstall || die "make install failed"
	rm -rf "${ED}"/usr/$(get_libdir)/bmore.help
	dodoc README CHANGES CREDITS bmore.help
	dohtml -r html/*
}
