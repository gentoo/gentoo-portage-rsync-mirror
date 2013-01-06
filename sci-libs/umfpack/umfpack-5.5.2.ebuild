# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/umfpack/umfpack-5.5.2.ebuild,v 1.6 2012/10/16 19:17:03 jlec Exp $

EAPI=4

AUTOTOOLS_AUTORECONF=yes

inherit autotools-utils fortran-2

MY_PN=UMFPACK

DESCRIPTION="Unsymmetric multifrontal sparse LU factorization library"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/umfpack"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc metis static-libs"

RDEPEND="
	virtual/blas
	sci-libs/amd
	metis? ( sci-libs/cholmod[metis] )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/5.5.1-autotools.patch )
DOCS=( README.txt Doc/ChangeLog )

S="${WORKDIR}/${MY_PN}"

src_configure() {
	myeconfargs+=(
		--with-blas="$(pkg-config --libs blas)"
		$(use_with metis cholmod)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	use doc && dodoc Doc/*.pdf
}
