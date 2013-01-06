# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/dinero/dinero-4.7.ebuild,v 1.10 2010/08/13 12:21:33 xarthisius Exp $

inherit toolchain-funcs

MY_P="d${PV/./-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Cache simulator"
HOMEPAGE="http://www.cs.wisc.edu/~markhill/DineroIV/"
SRC_URI="ftp://ftp.cs.wisc.edu/markhill/DineroIV/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="as-is"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e "s/\$(CC)/& \$(LDFLAGS)/" \
	  -i Makefile.in || die #331837
}

src_compile() {
	tc-export AR CC RANLIB
	econf
	emake || die "emake failed"
}

src_install() {
	dobin dineroIV || die "dobin failed"
	dodoc CHANGES COPYRIGHT NOTES README TODO || die "dodoc failed"
}
