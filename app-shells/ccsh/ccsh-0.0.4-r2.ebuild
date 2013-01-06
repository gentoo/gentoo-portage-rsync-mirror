# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ccsh/ccsh-0.0.4-r2.ebuild,v 1.18 2008/12/30 20:40:07 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="UNIX Shell for people already familiar with the C language"
HOMEPAGE="http://ccsh.sourceforge.net/"
SRC_URI="http://download.sourceforge.net/ccsh/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	into /
	dobin ccsh || die
	into /usr
	newman ccsh.man ccsh.1
	dodoc ChangeLog README TODO
}
