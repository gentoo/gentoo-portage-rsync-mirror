# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ccsh/ccsh-0.0.4-r3.ebuild,v 1.1 2012/10/15 09:56:12 pinkbyte Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="UNIX Shell for people already familiar with the C language"
HOMEPAGE="http://ccsh.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/ccsh/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)"
}

src_install() {
	dobin ccsh
	newman ccsh.man ccsh.1
	dodoc ChangeLog README TODO
}
