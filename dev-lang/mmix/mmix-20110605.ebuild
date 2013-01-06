# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mmix/mmix-20110605.ebuild,v 1.3 2012/03/10 17:09:35 ranger Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Donald Knuth's MMIX Assembler and Simulator."
HOMEPAGE="http://www-cs-faculty.stanford.edu/~knuth/mmix.html"
SRC_URI="http://www-cs-faculty.stanford.edu/~knuth/programs/${P}.tar.gz"

DEPEND="|| ( >=dev-util/cweb-3.63 virtual/tex-base )"
RDEPEND=""

SLOT="0"
LICENSE="mmix"
KEYWORDS="~amd64 ppc x86"
IUSE="doc"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-20110420-makefile.patch
}

src_compile() {
	emake all \
		CFLAGS="${CFLAGS}" \
		CC=$(tc-getCC) \
		|| die
	if use doc ; then
		emake doc || die
	fi
}

src_install () {
	dobin mmix mmixal mmmix mmotype abstime || die
	dodoc README mmix.1 || die
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins *.ps || die
	fi
}
