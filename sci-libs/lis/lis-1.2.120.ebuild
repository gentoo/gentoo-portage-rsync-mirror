# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lis/lis-1.2.120.ebuild,v 1.1 2012/11/12 02:44:13 bicatali Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes
inherit autotools-utils fortran-2

DESCRIPTION="Library of Iterative Solvers for Linear Systems"
HOMEPAGE="http://www.ssisc.org/lis/index.en.html"
SRC_URI="http://www.ssisc.org/lis/dl/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc fma fortran mpi openmp quad saamg sse2 static-libs"

RDEPEND="mpi? ( virtual/mpi )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-autotools.patch )

pkg_setup() {
	if use openmp; then
		[[ $(tc-getCC)$ == *gcc* ]] && ! tc-has-openmp && \
			die "You have openmp enabled but your current gcc does not support it"
		export FORTRAN_NEED_OPENMP=1
	fi
	use fortran && fortran-2_pkg_setup
}

src_configure() {
	local myeconfargs=(
		$(use_enable fortran)
		$(use_enable openmp omp)
		$(use_enable quad)
		$(use_enable fma)
		$(use_enable sse2)
		$(use_enable saamg)
		$(use_enable mpi)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	use doc && dodoc doc/*.pdf
}
