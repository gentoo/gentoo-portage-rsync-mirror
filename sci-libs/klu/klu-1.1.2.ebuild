# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/klu/klu-1.1.2.ebuild,v 1.1 2011/08/07 00:54:52 bicatali Exp $

EAPI=4

inherit autotools eutils

MY_PN=KLU

DESCRIPTION="Sparse LU factorization for circuit simulation"
HOMEPAGE="http://www.cise.ufl.edu/research/sparse/klu/"
SRC_URI="http://www.cise.ufl.edu/research/sparse/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

DEPEND="sci-libs/amd
	sci-libs/btf
	sci-libs/colamd"
RDEPEND="${DEPEND}"

DOCS="README.txt Doc/ChangeLog"

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.1-autotools.patch
	sed -i -e "s/1.0.1/${PV}/" configure.ac || die
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use doc && dodoc Doc/*.pdf
}
