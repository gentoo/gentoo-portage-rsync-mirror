# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/e3/e3-2.7.1.ebuild,v 1.6 2010/03/30 22:39:27 fauli Exp $

DESCRIPTION="Very tiny editor in ASM with emacs, pico, wordstar, and vi keybindings"
HOMEPAGE="http://freshmeat.net/projects/e3/
	http://mitglied.multimania.de/albkleine/"
SRC_URI="http://mitglied.multimania.de/albkleine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND="x86? ( >=dev-lang/nasm-0.98.39-r3 )
	amd64? ( >=dev-lang/yasm-0.6.1 )"
RDEPEND=""

src_compile() {
	local target=""
	use amd64 && target="yasm64"
	emake ${target} || die "emake failed"
}

src_install() {
	dobin e3 || die "dobin failed"
	dosym e3 /usr/bin/e3em
	dosym e3 /usr/bin/e3ne
	dosym e3 /usr/bin/e3pi
	dosym e3 /usr/bin/e3vi
	dosym e3 /usr/bin/e3ws

	newman e3.man e3.1
	dodoc ChangeLog README
	dohtml e3.html
}
