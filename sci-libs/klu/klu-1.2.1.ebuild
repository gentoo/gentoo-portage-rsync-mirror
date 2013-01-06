# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/klu/klu-1.2.1.ebuild,v 1.1 2012/11/12 02:00:21 bicatali Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="Sparse LU factorization for circuit simulation"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/klu/"
SRC_URI="http://dev.gentoo.org/~bicatali/distfiles/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc static-libs"

RDEPEND="
	>=sci-libs/amd-1.3
	>=sci-libs/btf-1.2
	>=sci-libs/colamd-1.3"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( virtual/latex-base )"

src_configure() {
	local myeconfargs=(
		$(use_with doc)
	)
	autotools-utils_src_configure
}
