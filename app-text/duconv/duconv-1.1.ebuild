# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/duconv/duconv-1.1.ebuild,v 1.25 2011/02/06 05:53:06 leio Exp $

inherit toolchain-funcs base

DESCRIPTION="A small util that converts from dos<->unix"
SRC_URI="http://people.freenet.de/tfaehr/${PN}.tgz"
HOMEPAGE="http://people.freenet.de/tfaehr/linux.htm"

LICENSE="as-is"
KEYWORDS="amd64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
SLOT="0"
IUSE=""

S="${WORKDIR}"/home/torsten/gcc/${PN}

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )

src_compile() {
	einfo "$(tc-getCXX) ${CXXFLAGS} -Wall -D_GNU_SOURCE -c -o duconv.o duconv.cc"
	$(tc-getCXX) ${CXXFLAGS} -Wall -D_GNU_SOURCE -c -o duconv.o duconv.cc
	einfo "$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} -o duconv duconv.o"
	$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} -o duconv duconv.o
}

src_install () {
	dobin duconv || die
	doman duconv.1 || die
	dodoc Changes || die
}
