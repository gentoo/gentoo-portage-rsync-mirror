# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/dlib/dlib-18.4.ebuild,v 1.1 2013/09/09 16:56:44 bicatali Exp $

EAPI=5

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Numerical and networking C++ library"
HOMEPAGE="http://dlib.net/"
SRC_URI="mirror://sourceforge/dclib/${P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="blas doc examples jpeg lapack png test X"

RDEPEND="
	blas? ( virtual/blas )
	jpeg? ( virtual/jpeg )
	lapack? ( virtual/lapack )
	png? ( media-libs/libpng )
	X? ( x11-libs/libX11 )"
DEPEND="test? ( ${RDEPEND} )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-17.48-makefile-test.patch
}

src_test() {
	cd dlib/test
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}"
	./test --runall || die
}

src_install() {
	dodoc dlib/README.txt
	rm -r dlib/{README,LICENSE}.txt dlib/test || die
	doheader -r dlib
	use doc && dohtml -r docs/*
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
