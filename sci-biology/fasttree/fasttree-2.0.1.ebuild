# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/fasttree/fasttree-2.0.1.ebuild,v 1.2 2010/06/20 18:20:40 xarthisius Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="Fast inference of approximately-maximum-likelihood phylogenetic trees"
HOMEPAGE="http://www.microbesonline.org/fasttree/"
#SRC_URI="http://www.microbesonline.org/fasttree/FastTree.c"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

pkg_setup() {
	tc-export CC
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_install() {
	dobin FastTree FastTreeUPGMA || die
	insinto /usr/share/${PN}
	doins *.pl *.pm || die
	dodoc README* || die
}
