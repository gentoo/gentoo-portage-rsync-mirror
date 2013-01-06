# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prank/prank-111130.ebuild,v 1.2 2012/06/20 21:12:38 jlec Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="Probabilistic Alignment Kit"
HOMEPAGE="http://code.google.com/p/prank-msa/ http://www.ebi.ac.uk/goldman-srv/prank/prank/"
SRC_URI="http://prank-msa.googlecode.com/files/prank.src.${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

S="${WORKDIR}/prank-msa/src"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch
	sed \
		-e "s/\$(LINK)/& \$(LDFLAGS)/" \
		-e "s:/usr/lib:${EPREFIX}/usr/$(get_libdir):g" \
		-i Makefile || die
}

src_compile() {
	emake \
		LINK="$(tc-getCXX)" \
		CXX="$(tc-getCXX)" \
		CFLAGS="${CFLAGS}" \
		CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	dobin prank
}
