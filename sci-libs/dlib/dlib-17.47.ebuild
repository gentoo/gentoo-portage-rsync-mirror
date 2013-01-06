# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/dlib/dlib-17.47.ebuild,v 1.1 2012/08/02 22:16:36 bicatali Exp $

EAPI=4

DESCRIPTION="Numerical and networking C++ library"
HOMEPAGE="http://dlib.net/"
SRC_URI="mirror://sourceforge/dclib/${P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="blas doc examples jpeg lapack png X"

RDEPEND="blas? ( virtual/blas )
	jpeg? ( virtual/jpeg )
	lapack? ( virtual/lapack )
	png? ( media-libs/libpng )
	X? ( x11-libs/libX11 )"
DEPEND="${DEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${P}"

src_test() {
	cd dlib/test
	emake
	./test --runall || die
}

src_install() {
	dodoc dlib/README.txt
	rm -r dlib/{README,LICENSE}.txt dlib/test || diexs
	insinto /usr/include
	doins -r dlib
	use doc && dohtml docs/*
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
