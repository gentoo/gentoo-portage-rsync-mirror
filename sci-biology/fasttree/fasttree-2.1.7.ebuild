# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/fasttree/fasttree-2.1.7.ebuild,v 1.1 2013/12/20 09:20:44 jlec Exp $

EAPI=5

inherit cmake-utils

DESCRIPTION="Fast inference of approximately-maximum-likelihood phylogenetic trees"
HOMEPAGE="http://www.microbesonline.org/fasttree/"
SRC_URI="
	http://www.microbesonline.org/fasttree/FastTree-${PV}.c
	http://www.microbesonline.org/fasttree/FastTreeUPGMA.c -> FastTreeUPGMA-${PV}.c
	http://www.microbesonline.org/fasttree/MOTreeComparison.tar.gz -> MOTreeComparison-${PV}.tar.gz
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="double-precision openmp sse3"

REQUIRED_USE="?? ( double-precision sse3 )"

DOCS=( README )

src_unpack() {
	mkdir "${S}" || die
	cd "${S}" || die
	unpack ${A}
	cp "${DISTDIR}"/{FastTreeUPGMA-${PV}.c,FastTree-${PV}.c} . || die
}

src_prepare() {
	cp "${FILESDIR}"/CMakeLists.txt . || die
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVERSION="${PV}"
		$(cmake-utils_use_has sse3)
		$(cmake-utils_use_use openmp)
		$(cmake-utils_use_use double-precision double)
	)
	cmake-utils_src_configure
}
