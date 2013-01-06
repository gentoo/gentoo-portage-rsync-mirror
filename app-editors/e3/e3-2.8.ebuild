# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/e3/e3-2.8.ebuild,v 1.5 2012/06/09 14:47:27 jlec Exp $

EAPI=3

DESCRIPTION="Very tiny editor in ASM with emacs, pico, wordstar, and vi keybindings"
HOMEPAGE="http://sites.google.com/site/e3editor/"
SRC_URI="http://sites.google.com/site/e3editor/Home/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND=">=dev-lang/nasm-2.09.04"
RDEPEND=""

src_prepare() {
	sed -i 's/-D$(EXMODE)//' Makefile || die
}

src_compile() {
	if use amd64; then
		emake -- 64 || die
	else
		emake -- 32 || die
	fi
}

src_install() {
	dobin e3 || die
	dosym e3 /usr/bin/e3em
	dosym e3 /usr/bin/e3ne
	dosym e3 /usr/bin/e3pi
	dosym e3 /usr/bin/e3vi
	dosym e3 /usr/bin/e3ws

	newman e3.man e3.1 || die
	dohtml e3.html || die
	dodoc ChangeLog README README_OLD
}
