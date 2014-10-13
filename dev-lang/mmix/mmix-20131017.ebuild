# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/mmix/mmix-20131017.ebuild,v 1.3 2014/10/13 20:56:41 tamiko Exp $

EAPI="5"

inherit eutils toolchain-funcs

DESCRIPTION="Donald Knuth's MMIX Assembler and Simulator"
HOMEPAGE="http://www-cs-faculty.stanford.edu/~knuth/mmix.html"
SRC_URI="http://www-cs-faculty.stanford.edu/~knuth/programs/${P}.tgz"

DEPEND="virtual/tex-base
	doc? ( dev-texlive/texlive-genericrecommended )"
RDEPEND=""

SLOT="0"
LICENSE="${PN}"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

S="${WORKDIR}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-20110420-makefile.patch
}

src_compile() {
	emake all \
		CFLAGS="${CFLAGS}" \
		CC="$(tc-getCC)"

	if use doc ; then
		emake doc
	fi
}

src_install () {
	dobin ${PN} ${PN}al m${PN} mmotype abstime
	dodoc README ${PN}.1

	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins *.ps
	fi
}
