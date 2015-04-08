# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/contest/contest-0.61.ebuild,v 1.10 2009/03/19 16:57:54 josejx Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Test system responsiveness to compare different kernels"
HOMEPAGE="http://members.optusnet.com.au/ckolivas/contest/"
SRC_URI="http://members.optusnet.com.au/ckolivas/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=app-benchmarks/dbench-2.0"

src_unpack () {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/contest-fortify_sources.patch"

	#Removing -g
	sed -i "s:-g::" Makefile
	#Adding our cflags
	sed -i "s:-O2:${CFLAGS} ${LDFLAGS}:" Makefile
	sed -i -e "/^CC/s/gcc/$(tc-getCC)/" Makefile
}
src_compile() {
	emake || die
}

src_install() {
	dobin contest || die
	doman contest.1
	dodoc README
}
